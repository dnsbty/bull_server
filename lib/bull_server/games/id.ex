defmodule BullServer.Games.Id do
  @moduledoc """
  Generates Game IDs made up of random uppercase letters
  """
  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.codepoints
  @length 4

  @doc """
  Generate a random Game ID

  ## Examples

      iex> generate()
      "ABCD"
  """
  @spec generate() :: String.t
  def generate do
    1..@length
    |> Enum.map(fn(_) -> Enum.random(@chars) end)
    |> Enum.join("")
  end
end
