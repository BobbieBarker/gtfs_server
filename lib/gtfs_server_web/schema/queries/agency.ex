defmodule GtfsServerWeb.Schema.Queries.Agency do
  use Absinthe.Schema.Notation

  alias GtfsServerWeb.Resolvers

  object :agency_queries do
    field :agency, :agency, description: "Get Agency by Id" do

      arg :id, non_null(:id), description: "Agency Id"

      resolve &Resolvers.Agency.find/2
    end

    field :agencies, list_of(:agency), description: "List all or filtered agencies" do
      arg :agency_id, :string, description: "static gtfs agency id"
      arg :agency_name, :string, description: "Filters agencies based on their name."
      arg :first, :integer, description: "The next X agencies."
      arg :after, :integer, description: "Agencies occuring after the supplied agency id"
      arg :before, :integer, description: "Agencies occuring before the supplied agency id"
      resolve &Resolvers.Agency.all/2
    end
  end
end
