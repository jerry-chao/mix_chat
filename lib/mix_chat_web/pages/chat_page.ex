defmodule MixChatWeb.ChatPage do
  use Hologram.Page

  route "/chat"
  layout MixChatWeb.AppLayout

  def init(_params, component, _server) do
    # Demo user
    current_user = %{id: 1, username: "李明", email: "liming@example.com"}
    
    # Sample conversations for demo
    conversations = [
      %{id: 1, name: "张伟", is_group: false},
      %{id: 2, name: "李娜", is_group: false}
    ]
    
    # Sample messages
    messages = [
      %{id: 1, content: "你好！", user_id: 2, user: %{username: "张伟"}},
      %{id: 2, content: "你好，有什么可以帮到你？", user_id: 1, user: %{username: "李明"}},
      %{id: 3, content: "我需要一些关于项目的帮助。", user_id: 2, user: %{username: "张伟"}}
    ]
    
    component
    |> put_state(:current_user, current_user)
    |> put_state(:conversations, conversations)
    |> put_state(:selected_conversation, List.first(conversations))
    |> put_state(:messages, messages)
    |> put_state(:new_message, "")
  end

  def template do
    ~HOLO"""
    <div class="h-screen bg-white flex">
      <!-- Sidebar -->
      <div class="w-80 bg-gray-50 border-r border-gray-200 flex flex-col">
        <div class="p-4 border-b border-gray-200">
          <h1 class="text-xl font-semibold text-gray-900">MixChat</h1>
          <p class="text-sm text-gray-600 mt-1">Welcome, {@current_user.username}</p>
        </div>
        
        <div class="flex-1 overflow-y-auto">
          {%for conversation <- @conversations}
            <div class="flex items-center p-4 border-b border-gray-100 cursor-pointer hover:bg-gray-100">
              <div class="w-12 h-12 bg-gray-300 rounded-full flex items-center justify-center mr-3">
                <span class="text-gray-600 font-medium">U</span>
              </div>
              <div class="flex-1">
                <p class="text-sm font-medium text-gray-900">{conversation.name}</p>
                <p class="text-sm text-gray-500">Direct Message</p>
              </div>
            </div>
          {/for}
        </div>
      </div>

      <!-- Main Chat Area -->
      <div class="flex-1 flex flex-col">
        <div class="p-4 border-b border-gray-200 bg-white">
          <h2 class="text-lg font-semibold text-gray-900">{@selected_conversation.name}</h2>
        </div>

        <div class="flex-1 overflow-y-auto p-4 space-y-4">
          {%for message <- @messages}
            {%if message.user_id == @current_user.id}
              <div class="flex justify-end">
                <div class="max-w-xs lg:max-w-md">
                  <div class="bg-blue-600 text-white rounded-lg px-4 py-2">
                    <p class="text-sm">{message.content}</p>
                  </div>
                  <p class="text-xs text-gray-500 mt-1 text-right">You</p>
                </div>
              </div>
            {%else}
              <div class="flex justify-start">
                <div class="max-w-xs lg:max-w-md">
                  <div class="bg-gray-200 text-gray-900 rounded-lg px-4 py-2">
                    <p class="text-sm">{message.content}</p>
                  </div>
                  <p class="text-xs text-gray-500 mt-1">{message.user.username}</p>
                </div>
              </div>
            {/if}
          {/for}
        </div>

        <div class="p-4 border-t border-gray-200 bg-white">
          <div class="flex space-x-4">
            <input
              type="text"
              placeholder="Type a message..."
              class="flex-1 border border-gray-300 rounded-lg px-4 py-2"
              value={@new_message}
            />
            <button class="px-6 py-2 bg-blue-600 text-white rounded-lg font-medium">
              Send
            </button>
          </div>
        </div>
      </div>
    </div>
    """
  end
end