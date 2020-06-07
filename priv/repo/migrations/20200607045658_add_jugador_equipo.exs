defmodule Discuss.Repo.Migrations.AddJugadorEquipo do
  use Ecto.Migration

  def change do
    create table(:jugador_equipo) do
      add :jugador_id, references(:jugador)
      add :equipo_id, references(:equipo)
    end
  end
end
