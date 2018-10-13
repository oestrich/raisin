defmodule Raisin.GossipCallback do
  @moduledoc """
  Callback module for Gossip

  Plugs into the gossip network.
  """

  require Logger

  @behaviour Gossip.Client

  @impl true
  def user_agent(), do: "Raisin"

  @impl true
  def channels(), do: []

  @impl true
  def players(), do: []

  @impl true
  def message_broadcast(_message), do: :ok

  @impl true
  def player_sign_in(_game_name, _player_name), do: :ok

  @impl true
  def player_sign_out(_game_name, _player_name), do: :ok

  @impl true
  def players_status(_game_name, _player_names), do: :ok

  @impl true
  def tell_received(_from_game, _from_player, _to_player, _message), do: :ok

  @impl true
  def games_status(_game), do: :ok

  defmodule SystemCallback do
    @moduledoc """
    System callback module, the application level events
    """

    @behaviour Gossip.Client.SystemCallback

    alias Backbone.Sync

    def process(state, event = %{"event" => "sync/channels"}) do
      Sync.sync_channels(state, event)
    end

    def process(state, event = %{"event" => "sync/games"}) do
      Sync.sync_games(event)

      {:ok, state}
    end

    def process(state, event) do
      Logger.debug(fn ->
        "Received a new event - #{inspect(event)}"
      end)

      {:ok, state}
    end
  end
end