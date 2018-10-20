defmodule Raisin.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string, null: false)
      add(:password_hash, :string, null: false)
      add(:token, :uuid)

      timestamps()
    end

    create index(:users, ["lower(email)"], unique: true, name: :users_lower_email_index)
  end
end
