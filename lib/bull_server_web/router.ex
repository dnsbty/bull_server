defmodule BullServerWeb.Router do
  use BullServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BullServerWeb do
    pipe_through :api

    get "/", PageController, :index
    get "/status", PageController, :status
  end
end
