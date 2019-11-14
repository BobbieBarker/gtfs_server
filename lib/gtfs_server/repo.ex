defmodule GtfsServer.Repo do
  use Ecto.Repo,
    otp_app: :gtfs_server,
    adapter: Ecto.Adapters.Postgres
end
