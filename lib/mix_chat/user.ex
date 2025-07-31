defmodule MixChat.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :password_hash, :string
    field :avatar_url, :string
    field :password, :string, virtual: true

    has_many :messages, MixChat.Message
    has_many :conversation_participants, MixChat.ConversationParticipant
    has_many :conversations, through: [:conversation_participants, :conversation]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :avatar_url])
    |> validate_required([:username, :email, :password])
    |> validate_length(:username, min: 3, max: 20)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
