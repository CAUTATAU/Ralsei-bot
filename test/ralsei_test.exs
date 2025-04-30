defmodule RalseiTest do
  use ExUnit.Case
  doctest Ralsei

  test "greets the world" do
    assert Ralsei.hello() == :world
  end
end
