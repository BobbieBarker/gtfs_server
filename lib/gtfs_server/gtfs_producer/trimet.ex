defmodule GtfsServer.GtfsProducer.Trimet do
  @trimet_app_id Application.get_env(:gtfs_server, :trimet_app_id)

  @moduledoc ~S"""
    GtfsProducer.Trimet service is responsible for wrapping the Trimet
    developer API so that Trimet GTFS data can be consumed by our application.
  """

  def get_vehicle_posistion() do
    # response =
    #   |> vehicle_posistion_url_builder()
    #   |> HTTPoison.get([], hackney: [pool: :trimet_gtfs_pool])


  end
  # WIP
  # TODO figure out how to use protocall buffers in elixir
  # TODO figure out how to use the gtfs-realtime.proto
  defp vehicle_posistion_url_builder() do
    "http://developer.trimet.org/ws/V1/VehiclePositions?appID=#{@trimet_app_id}"
  end
end
