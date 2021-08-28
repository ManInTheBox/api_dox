defmodule ApiDoxWeb.ApiLive.FormComponent do
  use ApiDoxWeb, :live_component

  alias ApiDox.Apps

  @impl true
  def update(%{api: api} = assigns, socket) do
    changeset = Apps.change_api(api)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"api" => api_params}, socket) do
    changeset =
      socket.assigns.api
      |> Apps.change_api(api_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"api" => api_params}, socket) do
    save_api(socket, socket.assigns.action, api_params)
  end

  defp save_api(socket, :edit, api_params) do
    case Apps.update_api(socket.assigns.api, api_params) do
      {:ok, _api} ->
        {:noreply,
         socket
         |> put_flash(:info, "Api updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_api(socket, :new, api_params) do
    case Apps.create_api(api_params) do
      {:ok, _api} ->
        {:noreply,
         socket
         |> put_flash(:info, "Api created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
