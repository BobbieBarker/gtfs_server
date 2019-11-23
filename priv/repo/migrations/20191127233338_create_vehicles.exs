defmodule GtfsServer.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :vehicle_id, :integer, null: false
      add :label, :text, null: true
      add :license_plate, :text, null: true
      timestamps()
    end
  end
end
