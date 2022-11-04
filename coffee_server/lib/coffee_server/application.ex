defmodule CoffeeServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CoffeeServer.Repo,
      # Start the Telemetry supervisor
      CoffeeServerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CoffeeServer.PubSub},
      # Start the Endpoint (http/https)
      CoffeeServerWeb.Endpoint,
      CoffeeServerWeb.StationEndpoint
      # Start a worker by calling: CoffeeServer.Worker.start_link(arg)
      # {CoffeeServer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CoffeeServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CoffeeServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
