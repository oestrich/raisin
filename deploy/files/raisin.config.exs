use Mix.Config

config :raisin, Web.Endpoint,
  secret_key_base: "oHRHAkHzGQpG5pDTTk41NgBB6TfXAcZSYfoNZv6FQn7zR7RJA5g8BgosdK3CPRMs",
  http: [port: 4001],
  url: [host: "raisin.grapevine.haus", port: 443, scheme: "https"]

# Configure your database
database = [
  database: "raisin",
  pool_size: 15
]
config :raisin, Raisin.Repo, database
config :backbone, Backbone.Repo, database

config :gossip, :client_id, ""
config :gossip, :client_secret, ""
