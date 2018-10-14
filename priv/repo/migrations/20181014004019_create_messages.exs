defmodule Raisin.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add(:channel_name, :string, null: false)
      add(:game_name, :string, null: false)
      add(:player_name, :string, null: false)
      add(:message, :text, null: false)

      add(:channel_id, references(:channels))
      add(:game_id, references(:games))

      timestamps()
    end
  end
end
