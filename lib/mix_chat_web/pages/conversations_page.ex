defmodule MixChatWeb.ConversationsPage do
  use Hologram.Page

  route "/conversations"
  layout MixChatWeb.AppLayout

  def init(_params, component, _server) do
    # Demo user
    current_user = %{id: 1, username: "李明", email: "liming@example.com"}
    
    # Sample users for demo
    users = [
      %{id: 2, username: "张伟", status: "在线"},
      %{id: 3, username: "李娜", status: "离线"},
      %{id: 4, username: "王刚", status: "在线"},
      %{id: 5, username: "赵敏", status: "离线"},
      %{id: 6, username: "陈浩", status: "在线"},
      %{id: 7, username: "刘芳", status: "离线"}
    ]
    
    component
    |> put_state(:current_user, current_user)
    |> put_state(:users, users)
    |> put_state(:search_query, "")
  end

  def template do
    ~HOLO"""
    <div class="h-screen bg-gray-50 flex">
      <div class="w-80 bg-white border-r border-gray-200 flex flex-col">
        <div class="p-4 border-b border-gray-200">
          <h1 class="text-xl font-semibold text-gray-900">Start New Chat</h1>
          <a href="/chat" class="text-sm text-blue-600">Back to Chat</a>
        </div>

        <div class="p-4">
          <input
            type="text"
            placeholder="Search users..."
            class="w-full px-4 py-2 border border-gray-300 rounded-lg text-sm"
            value={@search_query}
          />
        </div>

        <div class="flex-1 overflow-y-auto">
          {%for user <- @users}
            <div class="flex items-center p-4 border-b border-gray-100 cursor-pointer hover:bg-gray-50">
              <div class="w-12 h-12 bg-gray-300 rounded-full flex items-center justify-center mr-3">
                <span class="text-gray-600 font-medium">U</span>
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-sm font-medium text-gray-900">{user.username}</p>
                <p class="text-sm text-gray-500">{user.status}</p>
              </div>
            </div>
          {/for}
        </div>
      </div>

      <div class="flex-1 flex items-center justify-center">
        <div class="text-center">
          <h2 class="text-2xl font-bold text-gray-900 mb-4">Start a New Conversation</h2>
          <p class="text-gray-600 mb-6">Select a user from the list to start chatting</p>
          <a href="/chat" class="inline-block px-6 py-3 bg-blue-600 text-white rounded-md font-medium">
            Back to Chat
          </a>
        </div>
      </div>
    </div>
    """
  end
end