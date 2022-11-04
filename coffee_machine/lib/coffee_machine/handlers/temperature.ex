defmodule CoffeeMachine.Handlers.Temperature do
  @moduledoc """
  Brewing temperatures by coffee type:
    * Espresso - 93 degrees Celsius
    * Pour Over - 90 degrees Celsius
    * French Press/Cafetiere - 93-94 degrees Celsius
    * AeroPress - 90-96 degrees Celsius
    * Chemex - 92-94 degrees Celsius

  Source: [Ueshima Coffee Co.](https://www.ueshimacoffeecompany.com/blogs/news/what-s-the-ideal-coffee-temperature).
  """
  @behaviour CoffeeMachine.Handler

  @impl true
  def perform(%{temp: temp, machine_type: machine_type}, callback) do
    max_temp = max_temp(machine_type)

    if temp <= max_temp do
      callback.({:ok, temp})
    else
      callback.({:error, :local_warming})
    end
  end

  defp max_temp(machine_type) do
    case machine_type do
      "espresso" -> 93
      "pour_over" -> 90
      "cafetiere" -> 94
      "aero_press" -> 96
      "chemex" -> 94
    end
  end
end
