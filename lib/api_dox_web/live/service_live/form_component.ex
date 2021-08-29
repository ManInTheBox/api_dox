defmodule ApiDoxWeb.ServiceLive.FormComponent do
  use ApiDoxWeb, :live_component

  alias ApiDox.Services

  @impl true
  def update(%{service: service} = assigns, socket) do
    changeset = Services.change_service(service)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"service" => service_params}, socket) do
    changeset =
      socket.assigns.service
      |> Services.change_service(service_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"service" => service_params}, socket) do
    save_service(socket, socket.assigns.action, service_params)
  end

  defp save_service(socket, :edit, service_params) do
    case Services.update_service(socket.assigns.service, service_params) do
      {:ok, _service} ->
        {:noreply,
         socket
         |> put_flash(:info, "Service updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_service(socket, :new, service_params) do
    case Services.create_service(service_params) do
      {:ok, _service} ->
        {:noreply,
         socket
         |> put_flash(:info, "Service created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
