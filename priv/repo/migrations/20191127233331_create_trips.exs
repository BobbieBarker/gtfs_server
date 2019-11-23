defmodule GtfsServer.Repo.Migrations.CreateTrips do
  use Ecto.Migration

  def change do
    create table(:trips) do
      add :trips_route_id, references(:routes)
      add :route_id, :integer, null: false
      add :trip_id, :id, null: false
      add :trip_headsign, :text, null: true
      add :direction_id, :integer, null: true
      add :wheelchair_accessible, :integer, null: true
      add :bikes_allowed, :integer, null: true
      timestamps()
    end
  end
end
