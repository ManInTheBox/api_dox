defmodule ApiDoxWeb.ApiLive.Index do
  use ApiDoxWeb, :live_view

  alias ApiDox.Apps
  alias ApiDox.Apps.Api

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :api_collection, list_api())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Api")
    |> assign(:api, Apps.get_api!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Api")
    |> assign(:api, %Api{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Api")
    |> assign(:api, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    api = Apps.get_api!(id)
    {:ok, _} = Apps.delete_api(api)

    {:noreply, assign(socket, :api_collection, list_api())}
  end

  defp list_api do
    Apps.list_api()
  end
end
