defmodule CoffeeMachineTest do
  use ExUnit.Case
  doctest CoffeeMachine

  test "greets the world" do
    assert CoffeeMachine.hello() == :world
  end
end
