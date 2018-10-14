defmodule Raisin.Messages do
  @moduledoc """
  Context for Gossip messages
  """

  alias Backbone.Channels
  alias Backbone.Games
  alias Raisin.Messages.Message
  alias Raisin.Repo

  @doc """
  Save a message from Gossip on a channel
  """
  def record(channel, game, name, message) do
    attributes = %{
      channel_name: channel,
      game_name: game,
      player_name: name,
      message: message
    }

    %Message{}
    |> Message.changeset(attributes)
    |> maybe_reference_channel(channel)
    |> maybe_reference_game(game)
    |> Repo.insert()
  end

  defp maybe_reference_channel(changeset, channel) do
    with {:ok, channel} <- Channels.get(channel) do
      Ecto.Changeset.put_change(changeset, :channel_id, channel.id)
    else
      _ ->
        changeset
    end
  end

  defp maybe_reference_game(changeset, game) do
    with {:ok, game} <- Games.get_by_name(game) do
      Ecto.Changeset.put_change(changeset, :game_id, game.id)
    else
      _ ->
        changeset
    end
  end
end
