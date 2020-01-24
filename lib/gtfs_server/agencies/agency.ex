defmodule GtfsServer.Agencies.Agency do
  use Ecto.Schema
  import Ecto.Changeset
  alias GtfsServer.Repo
  alias GtfsServer.Agencies

  @timestamps_opts [type: :utc_datetime]

  schema "agencies" do
    field :agency_id, :string
    field :agency_name, :string
    field :agency_url, :string
    field :agency_timezone, :string
    field :agency_lang, :string
    field :agency_phone, :string
    field :agency_fare_url, :string
    field :agency_email, :string
    has_one :gtfs_rt_configs, Agencies.GtfsRTConfig
    has_many :routes, Agencies.Route
    timestamps()
  end

  @available_fields [
    :agency_id,
    :agency_name,
    :agency_url,
    :agency_timezone,
    :agency_email
  ]
  @required_fields [
    :agency_id,
    :agency_name,
    :agency_url,
    :agency_timezone
  ]

  def create_changeset(params) do
    changeset(%GtfsServer.Agencies.Agency{}, params)
  end

  @doc false
  def changeset(agency, attrs) do
    agency
    |> Repo.preload([:gtfs_rt_configs, :routes])
    |> cast(attrs, @available_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:agency_id)
    |> cast_assoc(:gtfs_rt_configs)
    |> cast_assoc(:routes)
  end
end
