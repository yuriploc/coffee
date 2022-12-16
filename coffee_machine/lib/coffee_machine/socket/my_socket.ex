defmodule CoffeeMachine.Socket.MySocket do
  use CoffeeMachine.Socket.BrazilSocket, restart: :transient

  alias CoffeeMachine.Handlers.Temperature

  @impl Slipstream
  def handle_connect(%{assigns: %{machine_id: machine_id, topic: topic}} = socket) do
    IO.puts("WAT WAT WAT WAT WAT WAT WAT WAT WAT")
    {:ok, join(socket, topic, %{machine_id: machine_id})}
  end

  def handle_info(
        {:sensor_read, temp},
        %{assigns: %{machine_id: machine_id, machine_type: machine_type, topic: topic}} = socket
      ) do
    IO.inspect(temp, label: "#{machine_type} sensor")

    Temperature.perform(%{temp: temp, machine_type: machine_type}, fn
      {:ok, temp} ->
        push(socket, topic, "temp:read", %{status: :ok, id: machine_id, temp: temp})

      {:error, :local_warming} ->
        push(socket, topic, "temp:read", %{status: :error, id: machine_id, temp: temp})
    end)

    {:noreply, socket}
  end
end
