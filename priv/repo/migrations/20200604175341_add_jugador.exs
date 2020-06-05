defmodule Discuss.Repo.Migrations.AddJugador do
  use Ecto.Migration

  def change do
    create table(:jugador) do
      add :usuario_id, references(:usuario)
      add :nombre, :string
      add :apellido, :string
      add :celular, :string
      add :fechaNac, :date
      add :posicion, :string
      add :piernaBuena, :string

      timestamps()
    end
  end
end
