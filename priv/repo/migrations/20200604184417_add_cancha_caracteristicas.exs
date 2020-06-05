defmodule Discuss.Repo.Migrations.AddCanchaCaracteristicas do
  use Ecto.Migration

  def change do
    create table(:cancha_caracteristicas) do
      add :cancha_id, references(:cancha)
      add :caracteristicas_id, references(:caracteristicas)
    end
  end
end
