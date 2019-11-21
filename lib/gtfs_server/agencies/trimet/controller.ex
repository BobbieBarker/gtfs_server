defmodule GtfsServer.Agencies.Trimet.Producer do
  require Logger

  import GtfsServer.Agencies.Trimet.Service, only: [dedupe_feed: 2, process_feed: 2]

  alias GtfsServer.Agencies.Trimet.Client

  def get_next_feed_message(:trimet_vehicle_posistion_feed = feed_type) do
    with {:ok, entities} <- Client.get__vehicle_position_feed(feed_type) do
      entities
        |> dedupe_feed(feed_type)
        |> process_feed(feed_type)
        |> Enum.to_list # creating pull on our stream.
    end
  end

  def get_next_feed_message(:trimet_alert_feed = feed_type) do
    with {:ok, entities} <- Client.get_alert_feed(feed_type) do
      entities
        |> dedupe_feed(feed_type)
        |> process_feed(feed_type)
        |> Enum.to_list # creating pull on our stream.
    end
  end
end
