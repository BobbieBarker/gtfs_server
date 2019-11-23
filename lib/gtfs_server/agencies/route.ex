defmodule GtfsServer.Agencies.Route do
  use Ecto.Schema
  import Ecto.Changeset
  alias GtfsServer.Repo
  alias GtfsServer.Agencies.Route

  @timestamps_opts [type: :utc_datetime]

  schema "routes" do
    field :route_id, :id
    field :route_short_name, :string
    field :route_long_name, :string
    field :route_desc, :string
    field :route_type, RouteTypeEnum # enum.
    field :route_url, :string
    field :route_color, :string, defaults: "FFFFFF"
    field :route_text_color, :string, defaults: "000000"
    field :route_sort_order, :integer
    belongs_to :agency, GtfsServer.Agencies.Agency
    has_many :trips, GtfsServer.Agencies.Trip, foreign_key: :trips_route_id
    timestamps()
  end

  @available_fields [
    :route_id,
    :route_short_name,
    :route_long_name,
    :route_desc,
    :route_type,
    :route_url,
    :route_color,
    :route_text_color,
    :route_sort_order
  ]
  @required_fields [:route_id]

  def create_changeset(params) do
    changeset(%Route{}, params)
  end

  def changeset(route, attrs) do
    route
    |> Repo.preload([:trips])
    |> cast(attrs, @available_fields)
    |> cast_assoc(:trips)
    |> validate_required(@required_fields)
    |> assoc_constraint(:agency)
  end
end
