defmodule GtfsServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      GtfsServer.Scheduler,
      {Task.Supervisor, name: Task.TrimetVehiclePositionConsumerSupervisor, restart: :transient},
      {Task.Supervisor, name: Task.TrimetAlertConsumerSupervisor, restart: :transient},
      Supervisor.child_spec({GtfsServer.RtFeeds.Cache, [name: :trimet_vehicle_posistion_feed]}, id: :trimet_vehicle_posistion_feed),
      Supervisor.child_spec({GtfsServer.RtFeeds.Cache, [name: :trimet_alert_feed]}, id: :trimet_alert_feed),
      {DynamicSupervisor, name: GtfsServer.RtFeedSupervisor, strategy: :one_for_one},
      # connection pool for trimet
      :hackney_pool.child_spec(:trimet_gtfs_pool, timeout: 15000, max_connections: 100),
      # Start the Ecto repository
      GtfsServer.Repo,
      # Start the endpoint when the application starts
      GtfsServerWeb.Endpoint
      # Starts a worker by calling: GtfsServer.Worker.start_link(arg)
      # {GtfsServer.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GtfsServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GtfsServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
