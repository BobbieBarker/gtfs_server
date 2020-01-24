defmodule GtfsServerWeb.Types.Agency do
  use Absinthe.Schema.Notation
  # import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  import_types Absinthe.Type.Custom


  @desc "A representation of a tranportation agency"
  object :agency do
    field :id, :id
    field :agency_id, :string
    field :agency_name, :string
    field :agency_url, :string
    field :agency_timezone, :string
    field :agency_lang, :string
    field :agency_phone, :string
    field :agency_fare_url, :string
    field :agency_email, :string, description: "Contact email address for agency"
    field :updated_at, :datetime, description: "Indicates the last time the agency was updated"
    field :inserted_at, :datetime, description: "Indicates when the agency record was created"
  end
end
