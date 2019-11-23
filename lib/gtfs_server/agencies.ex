defmodule GtfsServer.Agencies do
  alias EctoShorts.Actions
  alias GtfsServer.Agencies

  @moduledoc """
    context defines the API for interacting with our internal representation
    of a transportation agency and it's related resources.
  """

  def list_agencies(params \\ %{}) do
    all_agencies = Actions.all(Agencies.Agency, params)

    {:ok, all_agencies}
  end

  def find_agency(params \\ %{}) do
    Actions.find(Agencies.Agency, params)
  end

  def update_agency(id, params) do
    Actions.update(Agencies.Agency, id, params)
  end

  def create_agency(params) do
    Actions.create(Agencies.Agency, params)
  end

  def update_stop(stop_id, params) do
    converted = Map.update(params, :stop_code, nil, &Integer.to_string(&1))

    Actions.update(Agencies.Stop, stop_id, converted)
  end

  def create_stop(%{stop_lat: lat , stop_lon: lon} = params) do
    stop_params = params
    |> Map.put(:location, %Geo.Point{ coordinates: {lat, lon}, srid: 4326})
    |> convert_stop_code_to_string
    |> Map.drop([:stop_lat, :stop_long])

    Actions.create(Agencies.Stop, stop_params)
  end

  def create_stop(params) do
    Actions.create(Agencies.Stop, convert_stop_code_to_string(params))
  end


  def update_route(route_id, params) do
    Actions.update(Agencies.Route, route_id, params)
  end

  def create_route(params) do
    Actions.create(Agencies.Route, params)
  end

  def create_trip(params) do
    Actions.create(Agencies.Trip, params)
  end

  def create_vehicle(params) do
    Actions.create(Agencies.Vehicle, params)
  end

  def create_stop_time(params) do
    Actions.create(Agencies.StopTime, params)
  end

  defp convert_stop_code_to_string(params) do
    Map.update(params, :stop_code, nil, &Integer.to_string(&1))
  end
end
