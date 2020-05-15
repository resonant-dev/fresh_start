defmodule FreshStart.Planner.Area do
  use Ecto.Schema
  import Ecto.Changeset

  alias FreshStart.Planner.Task

  schema "areas" do
    field :name, :string
    has_many(:tasks, Task)

    timestamps()
  end

  @doc false
  def changeset(area, attrs) do
    area
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
