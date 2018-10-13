defmodule Backbone.Games do
  @moduledoc """
  Context for caching remote games from Gossip
  """

  @type opts :: Keyword.t()

  alias Backbone.Games.Game
  alias Backbone.RemoteSchema

  import Ecto.Query

  @repo Raisin.Repo

  @doc """
  Get all games
  """
  @spec all(opts()) :: [Game.t()]
  def all(opts \\ []) do
    Game
    |> order_by([g], g.name)
    |> maybe_include_hidden(opts)
    |> @repo.all()
  end

  defp maybe_include_hidden(query, opts) do
    case Keyword.get(opts, :include_hidden, false) do
      false ->
        query |> where([g], g.display == true)

      true ->
        query
    end
  end

  @doc """
  Get a game by name
  """
  def get(id, opts \\ []) do
    case @repo.get_by(Game, Keyword.merge(opts, [id: id])) do
      nil ->
        {:error, :not_found}

      game ->
        {:ok, game}
    end
  end

  @doc """
  Get a game by name
  """
  def get_by_name(name, opts \\ []) do
    case @repo.get_by(Game, Keyword.merge(opts, [short_name: name])) do
      nil ->
        {:error, :not_found}

      game ->
        {:ok, game}
    end
  end

  @doc """
  Cache remote games

  Create or update remote games
  """
  def cache_remote(games) do
    Enum.each(games, &cache_game/1)

    :ok
  end

  defp cache_game(attributes) do
    remote_id = Map.get(attributes, "id")

    attributes = RemoteSchema.map_fields(attributes, %{
      "id" => "remote_id",
      "game" => "short_name",
      "display_name" => "name",
    })

    case @repo.get_by(Game, remote_id: remote_id) do
      nil ->
        %Game{}
        |> Game.changeset(attributes)
        |> @repo.insert()

      game ->
        game
        |> Game.changeset(attributes)
        |> @repo.update()
    end
  end
end