defmodule CoffeeMachine.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: CoffeeMachine.Worker.start_link(arg)
      # {CoffeeMachine.Worker, arg}
      {Task.Supervisor, name: CoffeeMachineTaskSupervisor},
      {Registry, name: CoffeeMachine.MachineRegistry, keys: :unique},
      {CoffeeMachine.Sensor, []},
      # {CoffeeMachine.Socket, uri: CoffeeMachine.MachineConfig.uri()}
      {CoffeeMachine.Socket.MySocket, uri: CoffeeMachine.MachineConfig.uri()}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CoffeeMachine.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
