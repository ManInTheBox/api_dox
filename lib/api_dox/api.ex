defmodule ApiDox.Api do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiDox.Api

  schema "api" do
    field :code, :string
    field :description, :string
    field :name, :string
    field :repository_url, :string

    timestamps()
  end

  @doc false
  def changeset(%Api{} = api, attrs) do
    api
    |> cast(attrs, [:code, :name, :description, :repository_url])
    |> validate_required([:code, :name, :description, :repository_url])
  end
end
