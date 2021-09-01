defmodule ApiDoxWeb.ServiceLive.Index do
  use ApiDoxWeb, :live_view

  alias ApiDox.Services
  alias ApiDox.Services.Service

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :service_collection, list_service())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"code" => code}) do
    socket
    |> assign(:page_title, "Edit Service")
    |> assign(:service, Services.get_by_code!(code))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Service")
    |> assign(:service, %Service{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Service")
    |> assign(:service, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    service = Services.get_service!(id)
    {:ok, _} = Services.delete_service(service)

    {:noreply, assign(socket, :service_collection, list_service())}
  end

  defp list_service do
    Services.list_service()
  end
end
