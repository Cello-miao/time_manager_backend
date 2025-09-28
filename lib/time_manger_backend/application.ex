defmodule TimeMangerBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TimeMangerBackendWeb.Telemetry,
      TimeMangerBackend.Repo,
      {DNSCluster, query: Application.get_env(:time_manger_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TimeMangerBackend.PubSub},
      # Start a worker by calling: TimeMangerBackend.Worker.start_link(arg)
      # {TimeMangerBackend.Worker, arg},
      # Start to serve requests, typically the last entry
      TimeMangerBackendWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TimeMangerBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TimeMangerBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
