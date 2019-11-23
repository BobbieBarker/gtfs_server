defmodule GtfsServer.Agencies.Trip do
  use Ecto.Schema
  import Ecto.Changeset
  alias GtfsServer.Agencies

  @timestamps_opts [type: :utc_datetime]

  schema "trips" do
    field :route_id, :integer
    field :trip_id, :id
    field :trip_headsign, :string
    field :direction_id, DirectionIdEnum
    field :wheelchair_accessible, AccessibilityEnum
    field :bikes_allowed, AccessibilityEnum
    belongs_to :route, Agencies.Route, foreign_key: :trips_route_id
    many_to_many :stops, Agencies.Stop, join_through: "stop_times"
    timestamps()
  end

  @available_fields [
    :route_id,
    :trip_id,
    :trip_headsign,
    :direction_id,
    :wheelchair_accessible,
    :bikes_allowed,
    :trips_route_id
  ]
  @required_fields [
    :route_id,
    :trip_id
  ]

  def create_changeset(params) do
    changeset(%Agencies.Trip{}, params)
  end

  def changeset(route, attrs) do
    route
    |> cast(attrs, @available_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:route)
  end
end
