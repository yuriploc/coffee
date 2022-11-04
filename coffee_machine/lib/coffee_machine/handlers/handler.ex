defmodule CoffeeMachine.Handler do
  @doc "Handles temperature depending on the machine type"
  @callback perform(payload :: map(), callback :: function()) :: term()
end
