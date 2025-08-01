defmodule MixChatWeb.LoginPage do
  use Hologram.Page

  route "/login"
  layout MixChatWeb.AppLayout

  def init(_params, component, _server) do
    component
    |> put_state(:email, "liming@example.com")
    |> put_state(:password, "password123")
    |> put_state(:message, "Demo login available")
  end

  def template do
    ~HOLO"""
    <div class="min-h-screen bg-gray-50 flex items-center justify-center">
      <div class="max-w-md w-full space-y-8">
        <div>
          <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">Welcome back</h2>
          <p class="mt-2 text-center text-sm text-gray-600">Please sign in to your account</p>
        </div>
        
        <div class="bg-blue-50 p-4 rounded-md">
          <p class="text-sm text-blue-700 font-medium">Demo Account:</p>
          <p class="text-sm text-blue-600">Email: {@email}</p>
          <p class="text-sm text-blue-600">Password: {@password}</p>
          <p class="text-sm text-blue-600">{@message}</p>
        </div>
        
        <div class="space-y-4">
          <a href="/chat" class="w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600">
            Enter Chat (Demo)
          </a>
          
          <div class="text-center space-y-2">
            <a href="/register" class="text-indigo-600">Don't have an account? Sign up</a>
            <br />
            <a href="/" class="text-gray-600">Back to Home</a>
          </div>
        </div>
      </div>
    </div>
    """
  end
end