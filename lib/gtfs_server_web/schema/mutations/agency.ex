defmodule GtfsServerWeb.Schema.Mutations.Agency do
  use Absinthe.Schema.Notation

  import_types Absinthe.Plug.Types
  alias GtfsServerWeb.Resolvers

  object :agency_mutations do

    field :upload_agency, :string do
      arg :agencies, non_null(:upload)

      resolve &Resolvers.Agency.upload/2
    end

  end
end
