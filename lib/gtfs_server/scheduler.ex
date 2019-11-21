defmodule GtfsServer.Scheduler do
  use Quantum.Scheduler,
    otp_app: :gtfs_server
end
