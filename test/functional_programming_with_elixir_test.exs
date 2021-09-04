defmodule FunctionalProgrammingWithElixirTest do
  use ExUnit.Case
  doctest FunctionalProgrammingWithElixir

  test "greets the world" do
    assert FunctionalProgrammingWithElixir.hello() == :world
  end
end
