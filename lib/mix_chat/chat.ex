defmodule MixChat.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false
  alias MixChat.Repo
  alias MixChat.{Conversation, Message, ConversationParticipant, User}

  @doc """
  Returns the list of conversations for a user.
  """
  def list_user_conversations(user_id) do
    from(c in Conversation,
      join: cp in ConversationParticipant,
      on: c.id == cp.conversation_id,
      where: cp.user_id == ^user_id,
      preload: [:users],
      order_by: [desc: c.updated_at]
    )
    |> Repo.all()
  end

  @doc """
  Gets a single conversation.
  """
  def get_conversation!(id), do: Repo.get!(Conversation, id)

  @doc """
  Gets a conversation with participants.
  """
  def get_conversation_with_participants!(id) do
    Repo.get!(Conversation, id)
    |> Repo.preload([:users, :messages])
  end

  @doc """
  Creates a conversation.
  """
  def create_conversation(attrs \\ %{}) do
    %Conversation{}
    |> Conversation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a direct conversation between two users.
  """
  def create_direct_conversation(user1_id, user2_id) do
    # Check if conversation already exists
    existing = get_direct_conversation(user1_id, user2_id)
    
    if existing do
      {:ok, existing}
    else
      user1 = Repo.get!(User, user1_id)
      user2 = Repo.get!(User, user2_id)
      
      conversation_name = "#{user1.username}, #{user2.username}"
      
      Repo.transaction(fn ->
        {:ok, conversation} = create_conversation(%{name: conversation_name, is_group: false})
        
        add_participant(conversation.id, user1_id)
        add_participant(conversation.id, user2_id)
        
        conversation
      end)
    end
  end

  @doc """
  Gets direct conversation between two users.
  """
  def get_direct_conversation(user1_id, user2_id) do
    from(c in Conversation,
      join: cp1 in ConversationParticipant,
      on: c.id == cp1.conversation_id,
      join: cp2 in ConversationParticipant,
      on: c.id == cp2.conversation_id,
      where: c.is_group == false,
      where: cp1.user_id == ^user1_id,
      where: cp2.user_id == ^user2_id,
      where: cp1.user_id != cp2.user_id
    )
    |> Repo.one()
  end

  @doc """
  Adds a participant to a conversation.
  """
  def add_participant(conversation_id, user_id) do
    %ConversationParticipant{}
    |> ConversationParticipant.changeset(%{
      conversation_id: conversation_id,
      user_id: user_id,
      joined_at: DateTime.utc_now()
    })
    |> Repo.insert()
  end

  @doc """
  Returns the list of messages for a conversation.
  """
  def list_messages(conversation_id, limit \\ 50) do
    from(m in Message,
      where: m.conversation_id == ^conversation_id,
      order_by: [asc: m.inserted_at],
      limit: ^limit,
      preload: [:user]
    )
    |> Repo.all()
  end

  @doc """
  Gets a single message.
  """
  def get_message!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.
  """
  def create_message(attrs \\ %{}) do
    changeset = %Message{}
    |> Message.changeset(attrs)
    
    case Repo.insert(changeset) do
      {:ok, message} ->
        # Update conversation timestamp
        Repo.get!(Conversation, message.conversation_id)
        |> Ecto.Changeset.change(updated_at: DateTime.utc_now())
        |> Repo.update()
        
        {:ok, Repo.preload(message, :user)}
      error ->
        error
    end
  end

  @doc """
  Updates a message.
  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a message.
  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.
  """
  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end
end