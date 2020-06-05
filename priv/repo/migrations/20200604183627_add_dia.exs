defmodule Discuss.Repo.Migrations.AddDia do
  use Ecto.Migration

  def change do
    create table(:dia) do
      add :nombre, :string
    end
  end
end
