defmodule ElixirIpcTest do
  use ExUnit.Case
  doctest ElixirIpc

  test "greets the world" do
    assert ElixirIpc.hello() == :world
  end
end
