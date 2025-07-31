defmodule MixChat.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conversations" do
    field :name, :string
    field :is_group, :boolean, default: false

    has_many :messages, MixChat.Message
    has_many :conversation_participants, MixChat.ConversationParticipant
    has_many :users, through: [:conversation_participants, :user]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:name, :is_group])
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 100)
  end
end
