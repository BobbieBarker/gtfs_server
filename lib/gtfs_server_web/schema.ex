defmodule GtfsServerWeb.Schema do
  use Absinthe.Schema

  alias GtfsServerWeb.Schema

  import_types GtfsServerWeb.Types.Agency
  import_types Schema.Queries.Agency
  import_types Schema.Mutations.Agency
  # import_types Schema.Subscriptions.User

  query do
    import_fields :agency_queries
  end

  mutation do
    import_fields :agency_mutations
  end

  # subscription do
  #   import_fields :user_subscriptions
  # end

  def context(ctx) do
    source = Dataloader.Ecto.new(GtfsServer.Repo)
    dataloader = Dataloader.add_source(Dataloader.new(), GtfsServer.Agencies, source)

    Map.put(ctx, :loader, dataloader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
