# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :raisin,
  namespace: Web,
  ecto_repos: [Backbone.Repo, Raisin.Repo]

# Configures the endpoint
config :raisin, Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q1KwEUV8LFTlP1vvUspSedvlSbJsdCwOENg6ZEDeYX+OEXPfw6L1xx+WpvAe8yyM",
  render_errors: [view: Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Raisin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :gossip, :callback_modules,
  core: Raisin.GossipCallback,
  players: Raisin.GossipCallback,
  tells: Raisin.GossipCallback,
  games: Raisin.GossipCallback,
  system: Raisin.GossipCallback.SystemCallback

config :backbone, :repo, Backbone.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
