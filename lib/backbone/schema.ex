defmodule Backbone.Schema do
  @moduledoc """
  Helper for setting up Ecto
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Backbone.Schema

      @repo Raisin.Repo

      @type t :: %__MODULE__{}
    end
  end
end
