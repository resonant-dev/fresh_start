defmodule FreshStart.PlannerTest do
  use FreshStart.DataCase

  alias FreshStart.Planner

  describe "tasks" do
    alias FreshStart.Planner.Task

    @valid_attrs %{body: "some body", order: "some order", title: "some title"}
    @update_attrs %{body: "some updated body", order: "some updated order", title: "some updated title"}
    @invalid_attrs %{body: nil, order: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Planner.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Planner.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Planner.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Planner.create_task(@valid_attrs)
      assert task.body == "some body"
      assert task.order == "some order"
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Planner.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Planner.update_task(task, @update_attrs)
      assert task.body == "some updated body"
      assert task.order == "some updated order"
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Planner.update_task(task, @invalid_attrs)
      assert task == Planner.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Planner.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Planner.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Planner.change_task(task)
    end
  end
end
