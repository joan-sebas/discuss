defmodule Discuss.Repo.Migrations.AddEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
        add :title, :string
        add :startDate, :date
        add :startTime, :time
        add :endDate, :date
        add :endTime, :time
        add :color, :string
        add :cancha_id, references(:cancha)
        add :jugador_id,  references(:jugador)
      end
  end
end
