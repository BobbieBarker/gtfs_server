defmodule GtfsServerWeb.Resolvers.Agency do
  # alias GtfsServer.Agencies

  def find(%{id: id}, _) do
    # Agencies.find_agency(%{id: id})
  end

  def all(params, _) do
    # Agencies.list_agencies(params)
  end

  def upload(args, _) do
    IO.inspect(args, label: "upload struct?")
  end
end
