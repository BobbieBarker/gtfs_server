defmodule GtfsServer.Agencies.GtfsRTConfig do
  use Ecto.Schema
  import Ecto.Changeset
  alias GtfsServer.Agencies.GtfsRTConfig

  @timestamps_opts [type: :utc_datetime]

  schema "gtfs_rt_configs" do
    field :base_url, :string
    field :vehicle_position_feed_path, :string
    field :alert_feed_path, :string
    field :trip_update_feed_path, :string
    field :route_config_path, :string
    belongs_to :agency, GtfsServer.Agencies.Agency
    timestamps()
  end

  @available_fields [
    :base_url,
    :vehicle_position_feed_path,
    :alert_feed_path,
    :trip_update_feed_path,
    :route_config_path
  ]

  def create_changeset(params) do
    changeset(%GtfsRTConfig{}, params)
  end

  @doc false
  def changeset(gtfs_rt_config, attrs) do
    gtfs_rt_config
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
    |> assoc_constraint(:agency)
  end
end
