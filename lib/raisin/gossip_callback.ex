defmodule Raisin.GossipCallback do
  @moduledoc """
  Callback module for Gossip

  Plugs into the gossip network.
  """

  require Logger

  alias Raisin.Messages
  alias Backbone.Sync

  @behaviour Gossip.Client.Core
  @behaviour Gossip.Client.Players
  @behaviour Gossip.Client.Tells
  @behaviour Gossip.Client.Games

  @impl true
  def user_agent(), do: Raisin.version()

  @impl true
  def channels(), do: []

  @impl true
  def players(), do: []

  @impl true
  def authenticated() do
    Sync.trigger_sync()
  end

  @impl true
  def message_broadcast(message) do
    Messages.record(message.channel, message.game, message.name, message.message)
  end

  @impl true
  def player_sign_in(_game_name, _player_name), do: :ok

  @impl true
  def player_sign_out(_game_name, _player_name), do: :ok

  @impl true
  def player_update(_game_name, _player_names), do: :ok

  @impl true
  def tell_receive(_from_game, _from_player, _to_player, _message), do: :ok

  @impl true
  def game_update(_game), do: :ok

  @impl true
  def game_connect(_game), do: :ok

  @impl true
  def game_disconnect(_game), do: :ok

  defmodule SystemCallback do
    @moduledoc """
    System callback module, the application level events
    """

    @behaviour Gossip.Client.SystemCallback

    alias Backbone.Channels
    alias Backbone.Sync

    @impl true
    def authenticated(state) do
      channels = Enum.map(Channels.all(), &(&1.name))
      {:ok, %{state | channels: channels}}
    end

    @impl true
    def process(state, event = %{"event" => "sync/achievements"}) do
      Sync.sync_achievements(event)
      {:ok, state}
    end

    def process(state, event = %{"event" => "sync/channels"}) do
      Sync.sync_channels(state, event)
    end

    def process(state, event = %{"event" => "sync/events"}) do
      Sync.sync_events(event)
      {:ok, state}
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
