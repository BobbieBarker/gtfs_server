defmodule GtfsServer.Config do
  @app :gtfs_server

  def trimet_url do
    "http://developer.trimet.org/ws/V1"
  end

  def trimet_app_id do
    Application.get_env(@app, :trimet_app_id)
  end
end
