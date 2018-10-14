defmodule Raisin.Messages.Message do
  @moduledoc """
  Schema for channels
  """

  use Raisin.Schema

  alias Backbone.Channels.Channel
  alias Backbone.Games.Game

  schema "messages" do
    field(:channel_name, :string)
    field(:game_name, :string)
    field(:player_name, :string)
    field(:message, :string)

    belongs_to(:channel, Channel)
    belongs_to(:game, Game)

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:channel_name, :game_name, :player_name, :message])
    |> validate_required([:channel_name, :game_name, :player_name, :message])
  end
end
