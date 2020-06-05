defmodule Discuss.Repo.Migrations.AddFechaEspecifica do
  use Ecto.Migration

  def change do
    create table(:fechaEspecifica) do
      add :cancha_id, references(:cancha)
      add :fechaEspecifica, :date
      add :horaApertura, :time
      add :horaCierre, :time
      add :precio, :float
    end
  end
end
