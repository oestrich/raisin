# Raisin

![Raisin](https://raisin.grapevine.haus/images/raisin.png)

Raisin is the moderation tool for [Gossip](https://github.com/oestrich/gossip).

- [MUD Coders Slack](https://slack.mudcoders.com/)
- [Patreon](https://www.patreon.com/exventure)

## Server

### Requirements

This is only required to run Grapevine itself, the server.

- PostgreSQL 10
- Elixir 1.7.2
- Erlang 21.0.5
- node.js 8.6

### Setup

```bash
mix deps.get
mix compile
cd assets && npm install && node node_modules/brunch/bin/brunch build && cd ..
mix ecto.reset
mix phx.server
```

This will start a web server on port 4003. You can now load [http://localhost:4003/](http://localhost:4003/) to view the application.

### Running Tests

```bash
MIX_ENV=test mix ecto.create
MIX_ENV=test mix ecto.migrate
mix test
```

## Colors

- Golden Yellow: `#FFCE00`
