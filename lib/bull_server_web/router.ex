defmodule BullServerWeb.Router do
  use BullServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BullServerWeb do
    pipe_through :api
  end
end
