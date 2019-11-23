defmodule GtfsServer.Repo.Migrations.CreateAgencies do
  use Ecto.Migration

  def change do
    create table(:agencies) do
      add :agency_id, :text, null: true # conditionally required.
      add :agency_name, :text, null: false
      add :agency_url, :text, null: false
      add :agency_timezone, :text, null: false
      add :agency_lang, :text, null: true # optional
      add :agency_phone, :text, null: true # optional
      add :agency_fare_url, :text, null: true# optional
      add :agency_email, :text, null: true  # optional
      timestamps()
    end

    create unique_index :agencies, [:agency_id]
  end
end
