defmodule Discuss.Repo.Migrations.AddCancha do
  use Ecto.Migration

  def change do
    create table(:cancha) do
      add :establecimiento_id, references(:establecimiento)
      add :numeroCancha, :int
      add :numeroJugadores, :int
      add :descripcion, :string
    end
  end
end
