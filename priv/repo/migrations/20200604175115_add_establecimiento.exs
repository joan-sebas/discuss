defmodule Discuss.Repo.Migrations.AddEstablecimiento do
  use Ecto.Migration

  def change do
    create table(:establecimiento) do
      add :idusuario, references(:usuario)
      add :nombre, :string
      add :direccion, :string
      add :telefono, :string
    end
  end
end
