defmodule Raisin.MessagesTest do
  use Raisin.DataCase

  alias Raisin.Messages

  describe "saving incoming messages" do
    test "basic saving" do
      {:ok, message} = Messages.record("channel", "game", "player", "Hi there")

      assert message.channel_name == "channel"
      assert message.game_name == "game"
      assert message.player_name == "player"
      assert message.message == "Hi there"

      refute message.channel_id
      refute message.game_id
    end

    test "saves the channel reference when it exists" do
      cache_channel(%{"name" => "channel"})

      {:ok, message} = Messages.record("channel", "game", "player", "Hi there")

      assert message.channel_id
    end

    test "saves the game reference when it exists" do
      cache_game(%{"game" => "game"})

      {:ok, message} = Messages.record("channel", "game", "player", "Hi there")

      assert message.game_id
    end
  end
end
