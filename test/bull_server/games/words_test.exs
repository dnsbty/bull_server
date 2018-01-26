defmodule BullServer.Games.WordsTest do
  use ExUnit.Case, async: true
  doctest BullServer.Games.Words, except: [random: 0], import: true
end
