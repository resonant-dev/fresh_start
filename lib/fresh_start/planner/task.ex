defmodule FreshStart.Planner.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :title, :string
    field :body, :string
    field :priority, :string
    field :status, :string
    field :order, :integer

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :body])
    |> validate_required([:title])
  end
end
