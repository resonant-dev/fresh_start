defmodule FreshStart.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :body, :string
      add :priority, :string
      add :status, :string
      add :order, :integer

      timestamps()
    end
  end
end
