defmodule Discuss.Repo.Migrations.AddCaracteristicas do
  use Ecto.Migration

  def change do
    create table(:caracteristicas) do
      add :nombre, :string
    end
  end
end
