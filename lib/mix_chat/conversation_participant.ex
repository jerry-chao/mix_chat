defmodule MixChat.ConversationParticipant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conversation_participants" do
    field :joined_at, :utc_datetime

    belongs_to :conversation, MixChat.Conversation
    belongs_to :user, MixChat.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(conversation_participant, attrs) do
    conversation_participant
    |> cast(attrs, [:joined_at, :conversation_id, :user_id])
    |> validate_required([:conversation_id, :user_id])
    |> unique_constraint([:conversation_id, :user_id])
  end
end
