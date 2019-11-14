# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gtfs_server,
  ecto_repos: [GtfsServer.Repo]

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

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
