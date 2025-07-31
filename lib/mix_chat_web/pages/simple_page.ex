defmodule MixChatWeb.SimplePage do
  use Hologram.Page

  route "/simple"
  layout MixChatWeb.AppLayout

  def init(_params, component, _server) do
    put_state(component, :message, "Hello World")
  end

  def template do
    ~HOLO"""
    <div>
      <h1>{@message}</h1>
      <button $click={:change_message}>Click me</button>
    </div>
    """
  end

  def action(:change_message, _params, component) do
    put_state(component, :message, "Button clicked!")
  end
end