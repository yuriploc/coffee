defmodule CoffeeServerWeb.StationChannel do
  use CoffeeServerWeb, :channel

  @impl Phoenix.Channel
  def join("station:data", params, socket) do
    machine_id = params["machine_id"]
    {:ok, machine_id, socket}
  end

  @impl Phoenix.Channel
  def handle_in("temp:read", message, socket) do
    {:noreply, socket}
  end
end
