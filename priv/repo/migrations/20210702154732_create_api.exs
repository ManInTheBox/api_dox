defmodule ApiDox.Repo.Migrations.CreateApi do
  use Ecto.Migration

  def change do
    create table(:api) do
      add :code, :string
      add :name, :string
      add :description, :string
      add :repository_url, :string

      timestamps()
    end

  end
end
