defmodule GtfsServer.Agencies.StopTime do
  use Ecto.Schema
  import Ecto.Changeset
  alias GtfsServer.Agencies

  @timestamps_opts [type: :utc_datetime]

  schema "stop_times" do
    belongs_to :trip, Agencies.Trip, foreign_key: :trip_stop_id
    belongs_to :stop, Agencies.Stop, foreign_key: :stop_trip_id
    field :trip_id, :id
    field :stop_id, :id
    field :arrival_time, :utc_datetime
    field :departure_time, :utc_datetime
    field :stop_sequence, :integer  #non-negative
    field :pickup_type, PickUpOrDropOffEnum # has a default
    field :drop_off_type, PickUpOrDropOffEnum # has a default
    field :shape_dist_traveled, :float #non-negative
    field :timepoint, TimePointEnum # has a default
    timestamps()
  end

  @available_fields [
    :trip_id,
    :stop_id,
    :arrival_time,
    :departure_time,
    :stop_sequence,
    :pickup_type,
    :drop_off_type,
    :shape_dist_traveled,
    :timepoint,
    :trip_stop_id,
    :stop_trip_id
  ]
  @required_fields [
    :trip_id,
    :stop_id,
    :stop_sequence,
    :trip_stop_id,
    :stop_trip_id
  ]

  def create_changeset(params) do
    changeset(%Agencies.StopTime{}, params)
  end

  def changeset(stop_time, attrs) do
    stop_time
    |> cast(attrs, @available_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:trip)
    |> assoc_constraint(:stop)
  end
end
