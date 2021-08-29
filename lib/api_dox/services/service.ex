defmodule ApiDox.Services.Service do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiDox.Services.Service

  schema "service" do
    field :api_spec, :string
    field :code, :string
    field :name, :string
    field :repository_url, :string

    timestamps()
  end

  @doc false
  def changeset(%Service{} = service, attrs) do
    service
    |> cast(attrs, [:code, :name, :repository_url, :api_spec])
    |> validate_required([:code, :name, :repository_url])
  end
end
