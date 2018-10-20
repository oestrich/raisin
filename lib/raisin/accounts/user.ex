defmodule Raisin.Accounts.User do
  @moduledoc """
  User schema
  """

  use Raisin.Schema

  schema "users" do
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)
    field(:password_hash, :string)
    field(:token, Ecto.UUID)

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:email, :password, :password_confirmation])
    |> trim(:email)
    |> validate_required([:email])
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> ensure(:token, UUID.uuid4())
    |> hash_password()
    |> validate_required([:password_hash])
    |> validate_confirmation(:password)
    |> unique_constraint(:email, name: :users_lower_email_index)
  end

  defp trim(changeset, field) do
    case get_change(changeset, field) do
      nil ->
        changeset

      value ->
        put_change(changeset, field, String.trim(value))
    end
  end

  defp hash_password(changeset) do
    case changeset do
      %{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
