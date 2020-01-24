defmodule GtfsServer.UploadProcessor do
  NimbleCSV.define(CSVParser, separator: ",")
  alias Utility
  alias GtfsServer.Agencies.Agency
  alias GtfsServer.Agencies.Route
  alias GtfsServer.Agencies.Trip
  alias GtfsServer.Agencies.Stop
  alias GtfsServer.Agencies.StopTime
  alias GtfsServer.Repo

  import Ecto.Changeset
  import GtfsServerWeb.ErrorHelpers, only: [translate_error: 1]

  require Logger

  @moduledoc """
    UploadProcessor opens up the gtfs zip archive
  """

  def process(path) do
    with {:ok, handle} <- get_zip_handle(path),
      :ok <- process_agencies(handle),
      :ok <- process_routes(handle),
      :ok <- process_trips(handle),
      :ok <- process_stops(handle)
      # :ok <- process_stop_times(handle)
    do
      {:ok, "success"}
    end
  end

  defp process_stop_times(handle) do
    handle
      |> open_file_contents_stream('stop_times.txt')
      |> Stream.map(fn x -> Map.update!(x, "timepoint", &String.to_integer(&1)) end)
      |> Stream.map(fn x -> Map.update!(x, "drop_off_type", &String.to_integer(&1)) end)
      |> Stream.map(fn x -> Map.update!(x, "pickup_type", &String.to_integer(&1)) end)
      |> Stream.map(fn x -> Map.update!(x, "stop_sequence", &String.to_integer(&1)) end)
      |> Stream.map(fn x -> Map.update!(x, "shape_dist_traveled", &String.to_float(&1)) end)
      |> Stream.map(&StopTime.changeset(%StopTime{}, &1))
      |> write_to_database()
  end

  defp process_stops(handle) do
    handle
      |> open_file_contents_stream('stops.txt')
      |> Stream.map(fn x -> Map.put(x, "location", Utility.create_geo_point_for_stop(x)) end)
      |> Stream.map(fn x -> Map.update!(x, "location_type", &String.to_integer(&1)) end)
      |> Stream.map(&Stop.changeset(%Stop{}, &1))
      |> write_to_database()
  end

  defp process_trips(handle) do
    handle
      |> open_file_contents_stream('trips.txt')
      |> Stream.map(fn x -> Map.update!(x, "route_id", &String.to_integer(&1)) end)
      |> Stream.map(fn x -> Map.update!(x, "trip_id", &String.to_integer(&1)) end)
      |> Stream.map(fn x -> Map.update!(x, "direction_id", &String.to_integer(&1)) end)
      |> Stream.map(fn x -> Map.update!(x, "wheelchair_accessible", &String.to_integer(&1)) end)
      |> Stream.map(&Trip.changeset(%Trip{}, &1))
      |> write_to_database()
  end

  defp process_routes(handle) do
    handle
      |> open_file_contents_stream('routes.txt')
      |> Stream.map(fn x -> Map.update!(x, "route_type", &String.to_integer(&1)) end)
      |> Stream.map(fn x -> Map.update!(x, "route_sort_order", &String.to_integer(&1)) end)
      |> Stream.map(&Route.changeset(%Route{}, &1))
      |> write_to_database()
  end

  defp process_agencies(handle) do
    handle
      |> open_file_contents_stream('agency.txt') # need to get rid of the header.
      |> Stream.map(&Agency.changeset(%Agency{}, &1))
      |> write_to_database()
  end

  defp write_to_database(stream) do
    stream
      |> Stream.with_index()
      |> Stream.chunk_every(250)
      |> Task.async_stream(&handle_insert(&1))
      |> Stream.run()
  end

  defp handle_insert(chunk) do
    with {:error, _, changeset, _} <- process_chunk(chunk)
    do
      errorMessage = Ecto.Changeset.traverse_errors(changeset, &translate_error/1)

      {:error, message: errorMessage}
    end
  end

  defp process_chunk(chunk) do
    chunk
      |> Enum.reduce(Ecto.Multi.new(), fn ({item, index}, multi) ->
        Ecto.Multi.insert(multi, Integer.to_string(index), item)
      end)
      |> Repo.transaction
  end

  defp get_current_tmp_dir(uploadPath) do
    uploadPath
      |> Path.dirname
      |> String.to_charlist()
  end

  defp get_zip_handle(upload_path) do
    upload_path
      |> String.to_charlist()
      |> :zip.zip_open([{:cwd, get_current_tmp_dir(upload_path)}])
  end

  defp open_file_contents_stream(handle, filename) do
    with {:ok, file} <- :zip.zip_get(filename, handle), do: parse_csv_file(file)
  end

  defp parse_csv_file(file) do
    file
      |> File.stream!()
      |> CSVParser.parse_stream(skip_headers: false)
      |> Stream.transform([], fn i, acc ->
        if length(acc) === 0, do: {[%{}], i}, else: Utility.zip_lists_into_map(i, acc)
      end)
      |> Stream.filter(&Utility.is_empty_map(&1))
  end

end
