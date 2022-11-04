defmodule CoffeeServer.Repo do
  use Ecto.Repo,
    otp_app: :coffee_server,
    adapter: Ecto.Adapters.Postgres
end
