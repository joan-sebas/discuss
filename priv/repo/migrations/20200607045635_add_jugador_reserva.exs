defmodule Discuss.Repo.Migrations.AddJugadorReserva do
  use Ecto.Migration

  def change do
    create table(:jugador_reserva) do
      add :jugador_id, references(:jugador)
      add :reserva_id, references(:reserva)
      add :equipo_id, references(:equipo)
      add :confirmacion, :boolean
      add :equipo, :int

      timestamps()
    end
  end
end
