defmodule MixChat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string

    belongs_to :user, MixChat.User
    belongs_to :conversation, MixChat.Conversation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :user_id, :conversation_id])
    |> validate_required([:content, :user_id, :conversation_id])
    |> validate_length(:content, min: 1, max: 1000)
  end
end
