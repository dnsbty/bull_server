defmodule BullServerWeb.PageController do
  use BullServerWeb, :controller

  def index(conn, _), do: redirect conn, external: "https://thebullgame.com"
end
