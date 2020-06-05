defmodule Discuss.Repo.Migrations.AddEstablecimiento do
  use Ecto.Migration

  def change do
    create table(:establecimiento) do
      add :usuario_id, references(:usuario)
      add :nombre, :string
      add :direccion, :string
      add :telefono, :string

      timestamps()
    end
  end
end
