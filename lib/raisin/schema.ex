defmodule Raisin.Schema do
  @moduledoc """
  Helper for setting up Ecto
  """

  import Ecto.Changeset, only: [get_field: 2, put_change: 3]

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Raisin.Schema

      @repo Raisin.Repo

      @type t :: %__MODULE__{}
    end
  end

  def ensure(changeset, field, default) do
    case get_field(changeset, field) do
      nil ->
        put_change(changeset, field, default)

      _ ->
        changeset
    end
  end
end
