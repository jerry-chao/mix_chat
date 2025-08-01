defmodule MixChatWeb.RegisterPage do
  use Hologram.Page

  route "/register"
  layout MixChatWeb.AppLayout

  def init(_params, component, _server) do
    component
    |> put_state(:message, "Registration coming soon")
  end

  def template do
    ~HOLO"""
    <div class="min-h-screen bg-gray-50 flex items-center justify-center">
      <div class="max-w-md w-full space-y-8">
        <div>
          <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">Create your account</h2>
          <p class="mt-2 text-center text-sm text-gray-600">{@message}</p>
        </div>
        
        <div class="space-y-4">
          <div class="text-center space-y-2">
            <a href="/login" class="text-indigo-600">Already have an account? Sign in</a>
            <br />
            <a href="/" class="text-gray-600">Back to Home</a>
          </div>
        </div>
      </div>
    </div>
    """
  end
end