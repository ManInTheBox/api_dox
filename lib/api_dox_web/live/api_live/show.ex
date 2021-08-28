defmodule ApiDoxWeb.ApiLive.Show do
  use ApiDoxWeb, :live_view

  alias ApiDox.Apps

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:api, Apps.get_api!(id))}
  end

  defp page_title(:show), do: "Show Api"
  defp page_title(:edit), do: "Edit Api"
end
