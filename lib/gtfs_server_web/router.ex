defmodule GtfsServerWeb.Router do
  use GtfsServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: GtfsServerWeb.Schema

    if Mix.env() === :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: GtfsServerWeb.Schema,
        socket: GtfsServerWeb.UserSocket,
        interface: :playground
    end
  end
end
