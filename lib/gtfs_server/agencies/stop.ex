defmodule GtfsServer.Agencies.Stop do
  use Ecto.Schema
  import Ecto.Changeset
  alias GtfsServer.Agencies

  @timestamps_opts [type: :utc_datetime]

  schema "stops" do
    field :stop_id, :id
    field :stop_code, :string
    field :stop_name, :string
    field :stop_desc, :string
    field :location, Geo.PostGIS.Geometry
    field :stop_url, :string
    field :location_type, LocationTypeEnum
    field :parent_station, :id
    field :stop_timezone, :string
    field :wheelchair_boarding, WheelChairBoardingEnum
    field :platform_code, :string
    many_to_many :trips, Agencies.Trip, join_through: "stop_times"
    timestamps()
  end

  @available_fields [
     :stop_id,
     :stop_code,
     :stop_name,
     :stop_desc,
     :location,
     :stop_url,
     :location_type,
     :parent_station,
     :stop_timezone,
     :wheelchair_boarding,
     :platform_code,
  ]

  @required_fields [
    :stop_id
  ]

  def create_changeset(params) do
    changeset(%Agencies.Stop{}, params)
  end

  def changeset(stop, attrs) do
    stop
    |> cast(attrs, @available_fields)
    |> validate_required(@required_fields)
  end
end

