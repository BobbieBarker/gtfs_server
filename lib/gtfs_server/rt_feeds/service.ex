defmodule GtfsServer.RtFeeds.Client.Service do
  alias Utility
  alias GtfsServer.RtFeeds.Cache
  alias GtfsServer.Protobufs.FeedEntity

  def dedupe_feed(feed_entities, feed_type) do
    feed_entities
      |> Stream.filter(&check_cache(&1, feed_type))
      |> Stream.each(&update_cache(&1, feed_type))
  end

  def process_feed(stream, :trimet_vehicle_posistion_feed) do
    Task.Supervisor.async_stream(
      Task.TrimetVehiclePositionConsumerSupervisor,
      stream,
      &do_some_thing/1
    )
  end

  def process_feed(stream, :trimet_alert_feed) do
    Task.Supervisor.async_stream(
      Task.TrimetAlertConsumerSupervisor,
      stream,
      &do_some_thing_else/1
    )
  end

  defp check_cache(%FeedEntity{} = feed_entity, :trimet_vehicle_posistion_feed = feed_type) do
    feed_entity
      |> Utility.create_vehicle_position_key
      |> Cache.lookup(feed_type)
  end

  defp check_cache(%FeedEntity{} = feed_entity, :trimet_alert_feed = feed_type) do
    feed_entity
      |> Utility.create_alert_key
      |> Cache.lookup(feed_type)
  end

  defp update_cache(%FeedEntity{} = feed_entity, :trimet_vehicle_posistion_feed = feed_type) do
    feed_entity
      |> Utility.create_vehicle_position_key
      |> Cache.insert(feed_type)
  end

  defp update_cache(%FeedEntity{} = feed_entity, :trimet_alert_feed = feed_type) do
    feed_entity
      |> Utility.create_alert_key
      |> Cache.insert(feed_type)
  end

  #refactor placeholder functions:
  # Eventually we'll replace with a call to a different module.
  defp do_some_thing(derp) do
    IO.inspect derp, label: "Feed entity?"
  end

  defp do_some_thing_else(derp) do
    # IO.puts "we did something else!!!"
    # IO.inspect derp
  end
end
