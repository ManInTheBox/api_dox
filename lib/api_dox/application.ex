defmodule ApiDox.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ApiDox.Repo,
      # Start the Telemetry supervisor
      ApiDoxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ApiDox.PubSub},
      # Start the Endpoint (http/https)
      ApiDoxWeb.Endpoint
      # Start a worker by calling: ApiDox.Worker.start_link(arg)
      # {ApiDox.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApiDox.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ApiDoxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
