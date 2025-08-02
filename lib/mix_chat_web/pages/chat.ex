defmodule MixChatWeb.Chat do
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
end
