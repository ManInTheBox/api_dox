defmodule ApiDox.Repo.Migrations.CreateService do
  use Ecto.Migration

  def change do
    create table(:service) do
      add :code, :string, null: false
      add :name, :string, null: false
      add :repository_url, :string, null: false
      add :api_spec, :string

      timestamps()
    end
  end
end
