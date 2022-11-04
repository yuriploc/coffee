import Config

config :coffee_machine,
  env: System.get_env("MIX_ENV", "#{config_env()}"),
  socket_host: System.get_env("SOCKET_HOST", "localhost"),
  socket_port: String.to_integer(System.get_env("SOCKET_PORT", "4001")),
  socket_path: System.get_env("SOCKET_PATH", "socket")
