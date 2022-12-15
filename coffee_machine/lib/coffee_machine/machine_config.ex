defmodule CoffeeMachine.MachineConfig do
  def machine_id, do: Application.fetch_env!(:machine, :id)

  # "sensor_data"
  def topic, do: Application.fetch_env!(:machine, :socket_topic)

  # ["espresso", "pour_over", "cafetiere", "aero_press", "chemex"]
  def type, do: Application.fetch_env!(:machine, :type)
end
