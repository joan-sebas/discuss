defmodule Discuss.Repo.Migrations.AddModificarJugadorReserva do
  use Ecto.Migration

  def change do
    alter table(:jugador_reserva) do
      add :numero_equipo, :integer
      remove :equipo
    end
  end
end
