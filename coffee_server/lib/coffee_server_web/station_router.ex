defmodule CoffeeServerWeb.StationRouter do
  use CoffeeServerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", CoffeeServerWeb do
    pipe_through(:api)
  end
end
