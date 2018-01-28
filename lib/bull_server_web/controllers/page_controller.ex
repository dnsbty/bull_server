defmodule BullServerWeb.PageController do
  use BullServerWeb, :controller

  def index(conn, _), do: redirect conn, external: "https://dennisbeatty.com"

  def status(conn, _), do: conn |> IO.inspect(label: "connection") |> json(%{status: "online"})
end
