defmodule Discuss.Repo.Migrations.AddReserva do
  use Ecto.Migration

  def change do
    create table(:reserva) do
      add :cancha_id, references(:cancha)
      add :fechaHora, :utc_datetime
      add :estado, :boolean

      timestamps()
    end
  end
end
