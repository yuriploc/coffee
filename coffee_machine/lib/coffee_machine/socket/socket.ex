defmodule CoffeeMachine.Socket do
  use Slipstream, restart: :permanent

  alias CoffeeMachine.{Handlers.Temperature, MachineConfig, MachineRegistry}

  @spec start_link(keyword()) ::
          {:ok, pid()} | :ignore | {:error, {:already_started, pid()} | term()}
  def start_link(config) do
    Slipstream.start_link(__MODULE__, config,
      name: {:via, Registry, {MachineRegistry, :machine_socket}}
    )
  end

  @impl Slipstream
  def init(config) do
    machine_id = MachineConfig.machine_id()
    machine_type = MachineConfig.type()
    topic = MachineConfig.topic()

    socket =
      config
      |> connect!()
      |> assign(machine_id: machine_id)
      |> assign(machine_type: machine_type)
      |> assign(topic: topic)

    {:ok, socket}
  end

  @impl Slipstream
  def handle_connect(%{assigns: %{machine_id: machine_id, topic: topic}} = socket) do
    {:ok, join(socket, topic, %{machine_id: machine_id})}
  end

  @impl Slipstream
  def handle_join(topic, _join_response, %{assigns: %{topic: topic}} = socket) do
    {:ok, socket}
  end

  @impl Slipstream
  def handle_info(
        {:sensor_read, temp},
        %{assigns: %{machine_id: machine_id, machine_type: machine_type, topic: topic}} = socket
      ) do
    IO.inspect(temp, label: "#{machine_type} sensor")

    run_handler(Temperature, %{temp: temp, machine_type: machine_type}, fn
      {:ok, temp} ->
        push(socket, topic, "temp:read", %{status: :ok, id: machine_id, temp: temp})

      {:error, :local_warming} ->
        push(socket, topic, "temp:read", %{status: :error, id: machine_id, temp: temp})
    end)

    {:noreply, socket}
  end

  defp run_handler(module, message, callback) do
    Task.Supervisor.start_child(CoffeeMachineTaskSupervisor, module, :perform, [message, callback])
  end
end
