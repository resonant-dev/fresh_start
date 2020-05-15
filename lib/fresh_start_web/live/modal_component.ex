defmodule FreshStartWeb.ModalComponent do
  use FreshStartWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div class="fixed bottom-0 z-10 inset-x-0 px-4 pb-4 sm:inset-0 sm:flex items-center justify-center">
      <div class="fixed inset-0 transition-opacity">
        <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
      </div>
      <div id="<%= @id %>" class="bg-white rounded-lg overflow-hidden shadow-xl transform transition-all sm:max-w-lg sm:w-full"
        phx-capture-click="close"
        phx-window-keydown="close"
        phx-key="escape"
        phx-target="#<%= @id %>"
        phx-page-loading>

        <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
          <%= live_patch to: @return_to, class: "float-right text-gray-400 focus:outline-none focus:text-gray-500 transition ease-in-out duration-150" do %>
            <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"/>
            </svg>
          <% end %>
          <%= live_component @socket, @component, @opts %>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
