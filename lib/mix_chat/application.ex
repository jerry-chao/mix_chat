defmodule MixChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MixChatWeb.Telemetry,
      MixChat.Repo,
      {DNSCluster, query: Application.get_env(:mix_chat, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MixChat.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MixChat.Finch},
      # Start a worker by calling: MixChat.Worker.start_link(arg)
      # {MixChat.Worker, arg},
      # Start to serve requests, typically the last entry
      MixChatWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MixChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MixChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
