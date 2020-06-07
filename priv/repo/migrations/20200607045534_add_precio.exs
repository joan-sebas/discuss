defmodule Discuss.Repo.Migrations.AddPrecio do
  use Ecto.Migration

  def change do
    create table(:precio) do
      add :dia_id, references(:dia)
      add :horaDesde, :time
      add :horaHasta, :time
      add :precio, :float
    end
  end
end
