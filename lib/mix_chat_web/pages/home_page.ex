defmodule MixChatWeb.HomePage do
  use Hologram.Page

  route "/"
  layout MixChatWeb.AppLayout

  def init(_params, component, _server) do
    put_state(component, :message, "Welcome to MixChat!")
  end

  def template do
    ~HOLO"""
    <div class="min-h-screen bg-gray-50 flex items-center justify-center">
      <div class="max-w-md w-full space-y-8">
        <div class="text-center">
          <h1 class="text-3xl font-bold text-gray-900 mb-2">MixChat</h1>
          <p class="text-gray-600 mb-8">{@message}</p>
          
          <div class="space-y-4">
            <a href="/login" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600">
              Login
            </a>
            <a href="/register" class="w-full flex justify-center py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white">
              Sign Up
            </a>
            <a href="/chat" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600">
              Enter Chat (Demo)
            </a>
          </div>
        </div>
      </div>
    </div>
    """
  end
end