defmodule FreshStartWeb.TaskLive.Index do
  use FreshStartWeb, :live_view

  alias FreshStart.Planner
  alias FreshStart.Planner.Task

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :tasks, fetch_tasks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Task")
    |> assign(:page_heading, "Tasks")
    |> assign(:task, Planner.get_task!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task")
    |> assign(:page_heading, "Tasks")
    |> assign(:task, %Task{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "List Tasks")
    |> assign(:page_heading, "Tasks")
    |> assign(:task, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    task = Planner.get_task!(id)
    {:ok, _} = Planner.delete_task(task)

    {:noreply, assign(socket, :tasks, fetch_tasks())}
  end

  defp fetch_tasks do
    Planner.list_tasks()
  end
end
