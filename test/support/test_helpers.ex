defmodule Raisin.TestHelpers do
  @moduledoc false

  alias Backbone.Channels
  alias Backbone.Games
  alias Raisin.Accounts

  def create_user(attributes \\ %{}) do
    attributes = Map.merge(%{
      email: "user@example.com",
      password: "password",
      password_confirmation: "password",
    }, attributes)

    {:ok, user} = Accounts.register(attributes)

    user
  end

  def cache_channel(attributes \\ %{}) do
    attributes = Map.merge(%{
      "id" => 1,
      "name" => "gossip",
      "hidden" => false,
    }, attributes)

    Channels.cache_remote([%{
      "action" => "create",
      "logged_at" => "2018-11-24T12:00:00Z",
      "payload" => attributes
    }])

    {:ok, channel} = Channels.get(attributes["name"])
    channel
  end

  def cache_game(attributes \\ %{}) do
    attributes = Map.merge(%{
      "id" => 1,
      "game" => "gossip",
      "display_name" => "Updated",
      "display" => true,
      "allow_character_registration" => true,
      "client_id" => UUID.uuid4(),
      "client_secret" => UUID.uuid4(),
      "redirect_uris" => [
        "https://example.com/oauth/callback"
      ]
    }, attributes)

    Games.cache_remote([%{
      "action" => "create",
      "logged_at" => "2018-11-24T12:00:00Z",
      "payload" => attributes
    }])

    {:ok, game} = Games.get_by_name(attributes["game"])
    game
  end
end
