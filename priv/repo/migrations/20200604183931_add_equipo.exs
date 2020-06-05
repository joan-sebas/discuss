defmodule Discuss.Repo.Migrations.AddEquipo do
  use Ecto.Migration

  def change do
    create table(:equipo) do
      add :jugador_id, references(:jugador)
      add :nombre, :string
      add :iniciales, :string

      timestamps()
    end
  end
end
