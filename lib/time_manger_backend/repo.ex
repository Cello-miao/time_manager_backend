defmodule TimeMangerBackend.Repo do
  use Ecto.Repo,
    otp_app: :time_manger_backend,
    adapter: Ecto.Adapters.Postgres
end
