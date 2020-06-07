defmodule Discuss.Repo.Migrations.AddReserva do
  use Ecto.Migration

  def change do
    create table(:reserva) do
      add :cancha_id, references(:cancha)
      add :fechaHora, :timestamptz
      add :estado, :boolean

      timestamps()
       timestamps(type: :timestamptz)
    end
  end
end
