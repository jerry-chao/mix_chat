# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MixChat.Repo.insert!(%MixChat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# Create users
users = [
  %{username: "liming", email: "liming@example.com", password: "password123"},
  %{username: "zhangwei", email: "zhangwei@example.com", password: "password123"},
  %{username: "lina", email: "lina@example.com", password: "password123"},
  %{username: "wanggang", email: "wanggang@example.com", password: "password123"},
  %{username: "zhaomin", email: "zhaomin@example.com", password: "password123"},
  %{username: "chenhao", email: "chenhao@example.com", password: "password123"},
  %{username: "liufang", email: "liufang@example.com", password: "password123"}
]

inserted_users =
  Enum.map(users, fn user_attrs ->
    case MixChat.Accounts.create_user(user_attrs) do
      {:ok, user} ->
        user

      {:error, changeset} ->
        # User might already exist, try to get by email
        MixChat.Accounts.get_user_by_email(user_attrs.email) ||
          raise "Failed to create user: #{inspect(changeset.errors)}"
    end
  end)

# Create some sample conversations
liming = Enum.find(inserted_users, &(&1.username == "liming"))
zhangwei = Enum.find(inserted_users, &(&1.username == "zhangwei"))
lina = Enum.find(inserted_users, &(&1.username == "lina"))

# Create direct conversations
{:ok, conv1} = MixChat.Chat.create_direct_conversation(liming.id, zhangwei.id)
{:ok, conv2} = MixChat.Chat.create_direct_conversation(liming.id, lina.id)

# Add some sample messages
messages = [
  %{content: "你好！", user_id: zhangwei.id, conversation_id: conv1.id},
  %{content: "你好，有什么可以帮到你？", user_id: liming.id, conversation_id: conv1.id},
  %{content: "我需要一些关于项目的帮助。", user_id: zhangwei.id, conversation_id: conv1.id},
  %{content: "好的，请详细说明。", user_id: liming.id, conversation_id: conv1.id},
  %{content: "Hi Lina! How are you?", user_id: liming.id, conversation_id: conv2.id},
  %{
    content: "I'm doing well, thanks! How about you?",
    user_id: lina.id,
    conversation_id: conv2.id
  }
]

Enum.each(messages, fn message_attrs ->
  case MixChat.Chat.create_message(message_attrs) do
    {:ok, _message} -> :ok
    {:error, changeset} -> IO.inspect(changeset.errors, label: "Failed to create message")
  end
end)

IO.puts("Database seeded successfully!")
