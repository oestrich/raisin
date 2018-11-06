use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :raisin, Web.Endpoint,
  http: [port: 4011],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :backbone, :repo, Raisin.Repo

# Configure your database
database = [
  database: "raisin_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
]
config :raisin, Raisin.Repo, database
config :backbone, Backbone.Repo, database

config :bcrypt_elixir, :log_rounds, 4
