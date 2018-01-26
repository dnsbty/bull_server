defmodule BullServer.WordsTest do
  use ExUnit.Case, async: true
  doctest BullServer.Words, except: [random: 0], import: true
end
