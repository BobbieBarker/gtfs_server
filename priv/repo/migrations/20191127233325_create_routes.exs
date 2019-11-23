defmodule GtfsServer.Repo.Migrations.CreateRoutes do
  use Ecto.Migration

  def change do
    create table(:routes) do
      add :agency_id, references(:agencies, on_delete: :delete_all)
      add :route_id, :id, null: false
      add :route_short_name, :text, null: true
      add :route_long_name, :text, null: true
      add :route_desc, :text, null: true
      add :route_type, :integer, null: true #enum
      add :route_url, :text, null: true
      add :route_color, :text, null: true
      add :route_text_color, :text, null: true
      add :route_sort_order, :integer, null: true
      timestamps()
    end

    create unique_index(:routes, [:agency_id, :route_id])
  end
end
