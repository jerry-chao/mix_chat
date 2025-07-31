defmodule MixChat.Repo do
  use Ecto.Repo,
    otp_app: :mix_chat,
    adapter: Ecto.Adapters.Postgres
end
