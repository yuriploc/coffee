defmodule CoffeeMachine.MachineConfig do
  def machine_id, do: Application.fetch_env!(:coffee_machine, :id)

  # "sensor_data"
  def topic, do: Application.fetch_env!(:coffee_machine, :socket_topic)

  # ["espresso", "pour_over", "cafetiere", "aero_press", "chemex"]
  def type, do: Application.fetch_env!(:coffee_machine, :type)

  def uri do
    host = Application.fetch_env!(:coffee_machine, :socket_host)
    port = Application.fetch_env!(:coffee_machine, :socket_port)
    path = Application.fetch_env!(:coffee_machine, :socket_path)

    "ws://#{host}:#{port}/#{path}/websocket"
  end
end
