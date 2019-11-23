defmodule GtfsServer.Agencies.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset
  alias GtfsServer.Agencies.Vehicle

  @timestamps_opts [type: :utc_datetime]

  schema "vehicles" do
    field :vehicle_id, :integer
    field :label, :string
    field :license_plate, :string
    timestamps()
  end

  @available_fields [:vehicle_id, :label, :license_plate]
  @required_fields [:vehicle_id]

  def create_changeset(params) do
    changeset(%Vehicle{}, params)
  end

  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, @available_fields)
    |> validate_required(@required_fields)
  end
end
