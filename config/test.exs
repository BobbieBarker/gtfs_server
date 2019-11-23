use Mix.Config

# Configure your database
config :gtfs_server, GtfsServer.Repo,
  username: "postgres",
  password: "postgres",
  database: "gtfs_server_test",
  hostname: "localhost",
  adapter: Ecto.Adapters.Postgres,
  types: GtfsServer.PostgresTypes,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gtfs_server, GtfsServerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :debug

config :ecto_shorts,
  repo: GtfsServer.Repo,
  error_module: EctoShorts.Actions.Error
