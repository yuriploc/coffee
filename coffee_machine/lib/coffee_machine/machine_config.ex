defmodule CoffeeMachine.MachineConfig do
  def machine_id, do: Enum.random(1..500)

  def topic, do: "station:data"

  def type, do: Enum.random(["espresso", "pour_over", "cafetiere", "aero_press", "chemex"])
end
