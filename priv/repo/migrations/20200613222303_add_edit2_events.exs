defmodule Discuss.Repo.Migrations.AddEditEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :estado, :boolean
    end
  end
end
