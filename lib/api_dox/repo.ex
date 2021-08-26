defmodule ApiDox.Repo do
  use Ecto.Repo,
    otp_app: :api_dox,
    adapter: Ecto.Adapters.MyXQL
end
