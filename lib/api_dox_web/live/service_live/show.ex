defmodule ApiDoxWeb.ServiceLive.Show do
  use ApiDoxWeb, :live_view

  alias ApiDox.Services

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"code" => code}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:service, Services.get_by_code!(code))}
  end

  defp page_title(:show), do: "Show Service"
  defp page_title(:edit), do: "Edit Service"
end
