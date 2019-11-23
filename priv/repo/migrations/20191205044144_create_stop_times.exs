defmodule GtfsServer.Repo.Migrations.CreateStopTimes do
  use Ecto.Migration

  def change do
    create table(:stop_times) do
      add :trip_id, :id, null: false
      add :stop_id, :id, null: false
      add :arrival_time, :utc_datetime, null: true
      add :departure_time, :utc_datetime, null: true
      add :stop_sequence, :integer, null: false
      add :pickup_type, :integer, null: true
      add :drop_off_type, :integer, null: true
      add :shape_dist_traveled, :float, null: true
      add :timepoint, :integer, null: true
      add :trip_stop_id, references(:trips)
      add :stop_trip_id, references(:stops)
      timestamps()
    end

    create unique_index(:stop_times, [:trip_stop_id, :stop_trip_id])
  end
end
