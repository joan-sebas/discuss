defmodule Discuss.Jugador_Equipo do
  use Discuss.Web, :model

  schema "jugador_equipo" do
    belongs_to :jugador, Discuss.Jugador
    belongs_to :equipo, Discuss.Equipo
  end


end
