defmodule CoffeeMachine.MachineConfig do
  def machine_id, do: Enum.random(1..500)

  def topic, do: "station:data"

  def type, do: "chemex"
end
