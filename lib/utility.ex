defmodule Utility do
  alias GtfsServer.Protobufs.FeedEntity

  def create_vehicle_position_key(%FeedEntity{} = feed_entity) do
    "#{feed_entity.vehicle.vehicle.id}:#{feed_entity.vehicle.timestamp}"
  end

  def create_alert_key(%FeedEntity{} = feed_entity) do
    feed_entity.id
  end

  def is_empty_map(map) when map == %{}, do: false
  def is_empty_map(_), do: true

  def zip_lists_into_map(values, keys) do
    map = Enum.zip(keys, values)
      |> Enum.into(%{})

    {[map], keys}
  end

  def create_geo_point_for_stop(stop) do
    with {:ok, lat} <- Map.fetch(stop, "stop_lat"),
    {:ok, lon } <- Map.fetch(stop, "stop_lon") do
      %Geo.Point{ coordinates: {String.to_float(lat), String.to_float(lon)}, srid: 4326}
    else
      :error -> nil
    end
  end
end
