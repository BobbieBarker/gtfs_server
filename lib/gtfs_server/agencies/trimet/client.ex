defmodule GtfsServer.Agencies.Trimet.Client do
  use HTTPoison.Base
  alias GtfsServer.Config
  alias GtfsServer.Protobufs.FeedMessage
  alias GtfsServer.Agencies.Trimet

  require Logger

  @moduledoc """
  GtfsProducer.TrimetRT service is responsible for wrapping the Trimet GTFS-RT
  API so that Trimet GTFS-RT data can be injested to the platform.
  """
  def get__vehicle_position_feed(:trimet_vehicle_posistion_feed) do
    with {:error, message} <- fetch("/VehiclePositions")  do
      Logger.error("Trimet GTFS RT feed: #{message}")
      {:error, message}
    end
  end

  def get_alert_feed(:trimet_alert_feed) do
    with {:error, message} <- fetch("/FeedSpecAlerts")  do
      Logger.error("Trimet GTFS RT feed: #{message}")
      {:error, message}
    end
  end

  def fetch(endpoint) do
    case Trimet.Client.get(endpoint, [], hackney: [pool: :trimet_gtfs_pool]) do
      {:ok, %{status_code: 200, body: %{entity: entities}}} -> {:ok, entities}
      {:ok, %{status_code: 403, body: body}} -> {:error, body}
    end
  end

  def process_url(url) do
    Config.trimet_url() <> url <> "?appID=#{Config.trimet_app_id()}"
  end

  # WIP in the future we can triger different parsing behaviour based on content-type header
  def process_response(%{status_code: 200} = response) do
    Map.update!(response, :body, fn value -> Protobuf.Decoder.decode(value, FeedMessage) end)
  end

  def process_response(response) do
    response
  end
end


