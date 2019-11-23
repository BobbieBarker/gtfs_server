defmodule GtfsServer.Repo.Migrations.CreateAgencyGtfsRtConfigs do
  use Ecto.Migration

  def change do
    create table(:gtfs_rt_configs) do
      add :agency_id, references(:agencies, on_delete: :delete_all)
      add :base_url, :text, null: false
      add :vehicle_position_feed_path, :text, null: false
      add :alert_feed_path, :text, null: false
      add :trip_update_feed_path, :text, null: false
      add :route_config_path, :text, null: false
      timestamps()
    end
  end
end
