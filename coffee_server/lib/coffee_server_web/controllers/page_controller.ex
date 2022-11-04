defmodule CoffeeServerWeb.PageController do
  use CoffeeServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
