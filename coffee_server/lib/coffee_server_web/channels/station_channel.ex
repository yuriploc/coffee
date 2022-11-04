defmodule CoffeeServerWeb.StationChannel do
  use CoffeeServerWeb, :channel

  @impl Phoenix.Channel
  def join("station:data", params, socket) do
    IO.puts("++++ + JOINED")
    station_id = params["station_id"]
    {:ok, station_id, socket}
  end

  @impl Phoenix.Channel
  def handle_in("temp", _message, socket) do
    {:noreply, socket}
  end
end
