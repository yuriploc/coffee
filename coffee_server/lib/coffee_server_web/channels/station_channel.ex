defmodule CoffeeServerWeb.StationChannel do
  use CoffeeServerWeb, :channel

  @impl Phoenix.Channel
  def join("station:data", params, socket) do
    IO.puts("++++ + JOINED")
    machine_id = params["machine_id"]
    {:ok, machine_id, socket}
  end

  @impl Phoenix.Channel
  def handle_in("temp:read", message, socket) do
    IO.inspect(message, label: "++++ + Got")
    {:noreply, socket}
  end
end
