defmodule ApiDox.Repo.Migrations.CreateApi do
  use Ecto.Migration

  def change do
    create table(:api) do
      add :name, :string
      add :code, :string

      timestamps()
    end

  end
end
