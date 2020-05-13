defmodule FreshStart.Repo do
  use Ecto.Repo,
    otp_app: :fresh_start,
    adapter: Ecto.Adapters.Postgres
end
