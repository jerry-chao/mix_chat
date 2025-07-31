defmodule MixChat.Repo.Migrations.CreateConversationParticipants do
  use Ecto.Migration

  def change do
    create table(:conversation_participants) do
      add :joined_at, :utc_datetime, default: fragment("NOW()")
      add :conversation_id, references(:conversations, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:conversation_participants, [:conversation_id])
    create index(:conversation_participants, [:user_id])
    create unique_index(:conversation_participants, [:conversation_id, :user_id])
  end
end
