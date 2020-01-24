defmodule GtfsServerWeb.Resolvers.Agency do
  alias GtfsServer.Agencies

  def find(%{id: id}, _) do
    # Agencies.find_agency(%{id: id})
  end

  def all(params, _) do
    # Agencies.list_agencies(params)
  end

  #WIP figure out how to validate the payload to only allow zip files
  def upload(%{agencies: %Plug.Upload{} = upload}, _) do
    Agencies.process_gtfs_upload(upload)
  end

end
