# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gtfs_server,
  ecto_repos: [GtfsServer.Repo]

config :ecto_shorts,
  repo: GtfsServer.Repo,
  error_module: EctoShorts.Actions.Error

# Configures the endpoint
config :gtfs_server, GtfsServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fQ7PEdDalbRsUeyUu8JcuUSV2yT8csb7WZYEa/6adxjG5KmP7I86e1/F2dkFmKYc",
  render_errors: [view: GtfsServerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: GtfsServer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# config :gtfs_server, GtfsServer.Scheduler,
#   debug_logging: false,
#   jobs: [
#     trimet_vehicle_posistion_feed: [
#       schedule: {:extended, "*/2"}, # Runs every 2 seconds,
#       task: {GtfsServer.RtFeeds.Consumer, :get_next_feed_message, [:trimet_vehicle_posistion_feed]
#     }],
#     trimet_alert_feed: [
#       schedule: {:extended, "*/2"}, # Runs every 2 seconds,
#       task: {GtfsServer.RtFeeds.Consumer, :get_next_feed_message, [:trimet_alert_feed]
#     }]
#   ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
