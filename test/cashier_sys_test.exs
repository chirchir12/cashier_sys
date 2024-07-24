defmodule CashierSysTest do
  use ExUnit.Case
  doctest CashierSys

  test "greets the world" do
    assert CashierSys.hello() == :world
  end
end
