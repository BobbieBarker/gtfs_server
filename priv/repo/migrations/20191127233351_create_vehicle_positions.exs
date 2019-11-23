defmodule GtfsServer.Repo.Migrations.CreateVehiclePositions do
  use Ecto.Migration

  def change do
    create table(:vehicle_positions) do
      add :agency_id, references(:agencies, on_delete: :delete_all)
      add :vehicle_id, references(:vehicles)
      add :stop_id, references(:stops)
      add :trip_id, references(:trips)
      add :congestion_level, :text, null: true
      add :current_status, :text, null: true
      add :occupancy_status, :text, null: true
      add :position, :jsonb, null: true, default: "{}"
      add :timestamp, :utc_datetime, null: true
      timestamps()
    end
  end
end
