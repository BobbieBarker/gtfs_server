defmodule GtfsServer.Repo.Migrations.CreateStops do
  use Ecto.Migration

  def change do

    create table(:stops) do
      add :stop_id, :id, null: false # required
      add :stop_code, :text, null: true # optional
      add :stop_name, :text, null: true # conditionally required
      add :stop_desc, :text, null: true
      add :location, :geometry, null: true
      add :stop_url, :text, null: true
      add :location_type, :integer, null: true
      add :parent_station, :id, null: true
      add :stop_timezone, :text, null: true
      add :wheelchair_boarding, :text, null: true
      add :platform_code, :text, null: true
      timestamps()
      # add :level_id, references(:levels)
      # add :zone_id, references(:fares) # add this in a later migration
    end
  end
end
