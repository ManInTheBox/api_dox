defmodule ApiDox.Apps.Api do
  use Ecto.Schema
  import Ecto.Changeset

  schema "api" do
    field :code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(api, attrs) do
    api
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
  end
end
