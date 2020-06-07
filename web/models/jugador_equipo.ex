defmodule Discuss.Jugador_equipo do
  use Discuss.Web, :model

  schema "jugador_equipo" do
    belongs_to :jugador, Discuss.Jugador
    belongs_to :equipo, Discuss.Equipo
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[])


  end
end
