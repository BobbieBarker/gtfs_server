defmodule GtfsServerWeb.Router do
  use GtfsServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GtfsServerWeb do
    pipe_through :api
  end
end
