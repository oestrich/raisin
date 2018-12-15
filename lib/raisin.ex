defmodule Raisin do
  @moduledoc """
  Raisin keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @doc """
  Get the running version of Raisin
  """
  def version() do
    raisin =
      :application.loaded_applications()
      |> Enum.find(&(elem(&1, 0) == :raisin))

    "Raisin v#{elem(raisin, 2)}"
  end
end
