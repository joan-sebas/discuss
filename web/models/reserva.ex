defmodule Discuss.Reserva do
  use Discuss.Web, :model

  schema "reserva" do
    field :fechaHora, :utc_datetime
    field :estado, :boolean
    belongs_to :cancha, Discuss.Cancha
    has_many :jugador_reserva, Discuss.Jugador_reserva
    timestamps()
      timestamps(type: :utc_datetime)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:fechaHora, :estado])
    |> validate_required([:fechaHora, :estado])

  end


end
