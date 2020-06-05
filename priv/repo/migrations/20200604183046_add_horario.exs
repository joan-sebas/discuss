defmodule Discuss.Repo.Migrations.AddHorario do
  use Ecto.Migration

  def change do
    create table(:horario) do
      add :cancha_id, references(:cancha)
      add :precio_id, references(:precio)
      add :horaApertura, :time
      add :horaCierre, :time
    end
  end
end
