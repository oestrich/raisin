defmodule Raisin.Accounts do
  @moduledoc """
  Context for accounts
  """

  alias Raisin.Accounts.User
  alias Raisin.Repo

  @type id :: integer()
  @type user_params :: map()
  @type token :: String.t()

  @doc """
  Start a new user
  """
  @spec new() :: Ecto.Changeset.t()
  def new(), do: %User{} |> User.changeset(%{})

  @doc """
  Register a new user
  """
  @spec register(user_params()) :: {:ok, User.t()}
  def register(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Find a user by the token
  """
  @spec from_token(token()) :: {:ok, User.t()} | {:error, :not_found}
  def from_token(token) do
    case Repo.get_by(User, token: token) do
      nil ->
        {:error, :not_found}

      user ->
        {:ok, user}
    end
  end

  @doc """
  Get a user by id
  """
  @spec get(id()) :: {:ok, User.t()} | {:error, :not_found}
  def get(id) do
    case Repo.get_by(User, id: id) do
      nil ->
        {:error, :not_found}

      user ->
        {:ok, user}
    end
  end

  @doc """
  Validate a login
  """
  @spec validate_login(String.t(), String.t()) :: {:ok, User.t()} | {:error, :invalid}
  def validate_login(email, password) do
    case Repo.get_by(User, email: email) do
      nil ->
        Comeonin.Bcrypt.dummy_checkpw()
        {:error, :invalid}

      user ->
        check_password(user, password)
    end
  end

  defp check_password(user, password) do
    case Comeonin.Bcrypt.checkpw(password, user.password_hash) do
      true ->
        {:ok, user}

      false ->
        {:error, :invalid}
    end
  end
end
