defmodule CoffeeMachine.Socket do
  use Slipstream, restart: :permanent

  @topic "station:data"

  @spec start_link(keyword()) ::
          {:ok, pid()} | :ignore | {:error, {:already_started, pid()} | term()}
  def start_link(config) do
    Slipstream.start_link(__MODULE__, config,
      name: {:via, Registry, {CoffeeMachine.Registry, :station_socket}}
    )
  end

  @impl Slipstream
  def init(config) do
    {:ok, connect!(config)}
  end

  @impl Slipstream
  def handle_connect(socket) do
    {:ok, join(socket, @topic, %{station_id: 1})}
  end

  @impl Slipstream
  def handle_join(@topic, _join_response, socket) do
    IO.inspect(self(), label: "@ #{__MODULE__} self()")
    {:ok, socket}
  end

  @impl Slipstream
  def handle_info({:sensor_read, temp}, socket) do
    IO.inspect(temp, label: "@ Sensor read")

    {:noreply, socket}
  end
end
