defmodule CoffeeMachine.Socket.BrazilSocket do
  alias CoffeeMachine.{MachineConfig, MachineRegistry}

  defmacro __using__(opts) do
    quote location: :keep, bind_quoted: [opts: opts] do
      restart = Keyword.get(opts, :restart, :permanent)

      use Slipstream, restart: restart

      def child_spec(init_arg) do
        %{
          id: __MODULE__,
          start: {__MODULE__, :start_link, [init_arg]}
        }
        |> Supervisor.child_spec(unquote(Macro.escape(opts)))
      end

      def start_link(opts) do
        Slipstream.start_link(__MODULE__, opts,
          name: {:via, Registry, {MachineRegistry, :machine_socket}}
        )
      end

      @impl Slipstream
      def init(opts) do
        machine_id = MachineConfig.machine_id()
        IO.inspect(machine_id, label: "@ machine_id")
        machine_type = MachineConfig.type()
        topic = MachineConfig.topic()

        socket =
          opts
          |> connect!()
          |> assign(machine_id: machine_id)
          |> assign(machine_type: machine_type)
          |> assign(topic: topic)

        {:ok, socket}
      end

      @impl Slipstream
      def handle_connect(%{assigns: %{machine_id: machine_id, topic: topic}} = socket) do
        IO.puts("@@@@ CONNECTED!!")
        {:ok, join(socket, topic, %{machine_id: machine_id})}
      end

      @impl Slipstream
      def handle_join(topic, _join_response, %{assigns: %{topic: topic}} = socket) do
        {:ok, socket}
      end

      defoverridable init: 1, handle_connect: 1, handle_join: 3
    end
  end
end
