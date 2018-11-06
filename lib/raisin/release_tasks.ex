# From https://github.com/bitwalker/distillery/blob/master/docs/Running%20Migrations.md
defmodule Raisin.ReleaseTasks do
  @moduledoc false

  @start_apps [
    :crypto,
    :ssl,
    :postgrex,
    :ecto,
    :ecto_sql
  ]

  @apps %{
    backbone: [Backbone.Repo],
    raisin: [Raisin.Repo]
  }

  def migrate() do
    startup()

    # Run migrations
    Enum.each(@apps, &run_migrations_for/1)

    # Signal shutdown
    IO.puts("Success!")
    :init.stop()
  end

  defp startup() do
    IO.puts("Loading raisin...")

    # Load the code for raisin, but don't start it
    Application.load(:raisin)

    IO.puts("Starting dependencies..")
    # Start apps necessary for executing migrations
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    repos = List.flatten(Map.values(@apps))

    # Start the Repo(s) for raisin
    IO.puts("Starting repos..")
    Enum.each(repos, &(&1.start_link(pool_size: 2)))
  end

  def priv_dir(app), do: "#{:code.priv_dir(app)}"

  defp run_migrations_for({app, repos}) do
    IO.puts("Running migrations for #{app}")
    Enum.each(repos, fn repo ->
      Ecto.Migrator.run(repo, migrations_path(app), :up, all: true)
    end)
  end

  defp migrations_path(app), do: Path.join([priv_dir(app), "repo", "migrations"])
end
