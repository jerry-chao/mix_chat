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

  # Action to update the new message input
  def action(:update_new_message, params, component) do
    new_message = params["value"] || ""
    put_state(component, :new_message, new_message)
  end

  # Action to handle form submission
  def action(:send_message, _params, component) do
    send_message_action(component)
  end

  # Private helper function to handle message sending logic
  defp send_message_action(%{state: state} = component) do
    new_message = state.new_message

    # Don't send empty messages
    if String.trim(new_message) == "" do
      component
    else
      current_user = state.current_user
      messages = state.messages
      selected_conversation = state.selected_conversation

      # Create new message
      new_message_obj = %{
        id: System.unique_integer([:positive]),
        content: String.trim(new_message),
        user_id: current_user.id,
        user: current_user,
        conversation_id: selected_conversation.id,
        inserted_at: DateTime.utc_now()
      }

      # Add message to the list and clear input
      updated_messages = messages ++ [new_message_obj]

      component
      |> put_state(:messages, updated_messages)
      |> put_state(:new_message, "")
    end
  end
end
