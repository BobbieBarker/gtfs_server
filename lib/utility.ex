defmodule Utility do
  alias GtfsServer.Protobufs.FeedEntity

  def create_vehicle_position_key(%FeedEntity{} = feed_entity) do
    "#{feed_entity.vehicle.vehicle.id}:#{feed_entity.vehicle.timestamp}"
  end

  def create_alert_key(%FeedEntity{} = feed_entity) do
    feed_entity.id
  end
end
