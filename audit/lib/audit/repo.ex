defmodule Audit.Repo do
  use Ecto.Repo,
    otp_app: :audit,
    adapter: Ecto.Adapters.Postgres
end
