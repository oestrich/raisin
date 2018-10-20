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

    Channels.cache_remote([attributes])

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
    }, attributes)

    Games.cache_remote([attributes])

    {:ok, game} = Games.get_by_name(attributes["game"])
    game
  end
end
