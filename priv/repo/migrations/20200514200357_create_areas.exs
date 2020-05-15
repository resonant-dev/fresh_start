defmodule FreshStart.Repo.Migrations.CreateAreas do
  use Ecto.Migration

  def change do
    create table(:areas) do
      add :name, :string
      add :tasks, references(:tasks, on_delete: :nothing)

      timestamps()
    end

    create index(:areas, [:tasks])
  end
end
