use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :raisin, Web.Endpoint,
  http: [port: 4011],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :raisin, Raisin.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "raisin_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
