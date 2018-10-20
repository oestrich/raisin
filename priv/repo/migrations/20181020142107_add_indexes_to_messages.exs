defmodule Raisin.Repo.Migrations.AddIndexesToMessages do
  use Ecto.Migration

  def change do
    create index(:messages, :channel_name)
  end
end
