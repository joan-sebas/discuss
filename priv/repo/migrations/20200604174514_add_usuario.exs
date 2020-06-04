defmodule Discuss.Repo.Migrations.AddUsuario do
  use Ecto.Migration

  def change do
    create table(:usuario) do
      add :nickname, :string
      add :rol, :string
      add :contraseña, :string

      timestamps()
    end
  end
end
