defmodule BullServerWeb.PageController do
  use BullServerWeb, :controller

  def index(conn, _), do: redirect conn, external: "https://dennisbeatty.com"

  def status(conn, _), do: json conn, %{status: "online"}
end
