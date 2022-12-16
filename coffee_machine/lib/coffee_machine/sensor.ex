defmodule CoffeeMachine.Sensor do
  use GenServer

  alias CoffeeMachine.MachineRegistry

  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(_init_opts) do
    Process.send_after(self(), :read_temp, 3_000)
    {:ok, :ok}
  end

  @impl GenServer
  def handle_info(:read_temp, state) do
    temp = :rand.uniform(100)
    [{socket_pid, _}] = Registry.lookup(MachineRegistry, :machine_socket)

    Process.send(socket_pid, {:sensor_read, temp}, [])
    Process.send_after(self(), :read_temp, Enum.random(3_000..10_000))

    {:noreply, state}
  end
end
