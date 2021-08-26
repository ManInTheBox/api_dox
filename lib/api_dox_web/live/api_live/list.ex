defmodule ApiDoxWeb.ApiLive.List do
  use ApiDoxWeb, :live_view

  def mount(_params, _session, socket) do
    apis = [
      %{id: 1, name: "Presence"},
      %{id: 2, name: "PubSub"},
      %{id: 3, name: "Notification"},
      %{id: 4, name: "Session"},
      %{id: 5, name: "Watchvote"}
    ]
    {:ok, assign(socket, apis: apis)}
  end
end
