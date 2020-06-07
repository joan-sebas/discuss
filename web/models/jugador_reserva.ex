defmodule Discuss.Jugador_reserva do
  use Discuss.Web, :model

  schema "jugador_reserva" do
    field :confirmacion, :boolean
    field :numero_equipo, :integer
    belongs_to :jugador, Discuss.Jugador
    belongs_to :reserva, Discuss.Reserva
    belongs_to :equipo, Discuss.Equipo
      timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:confirmacion, :numero_equipo])
    |> validate_required([:confirmacion])

  end


end
