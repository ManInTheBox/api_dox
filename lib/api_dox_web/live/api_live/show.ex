defmodule ApiDoxWeb.ApiLive.Show do
  use ApiDoxWeb, :live_view

  def mount(%{"id" => id}, _session, socket) do
    apis = [
      %{id: 1, name: "Presence"},
      %{id: 2, name: "PubSub"},
      %{id: 3, name: "Notification"},
      %{id: 4, name: "Session"},
      %{id: 5, name: "Watchvote"}
    ]
    api = Enum.find(apis, %{id: 3, name: "Notification"}, fn api ->
      api.id === String.to_integer(id)
    end)
    socket = assign(socket, api: api)
    {:ok, socket}
  end
end
