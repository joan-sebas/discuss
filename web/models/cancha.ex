defmodule Discuss.Cancha do
  use Discuss.Web, :model

  schema "cancha" do
    field :numeroCancha, :integer
    field :numeroJugadores, :integer
    field :descripcion, :string
    belongs_to :establecimiento, Discuss.Establecimiento
    has_many :reserva, Discuss.Reserva
    has_many :fechaEspecifica, Discuss.FechaEspecifica
    has_many :horario, Discuss.Horario
    has_many :cancha_caracteristicas, Discuss.Cancha_caracteristicas
    has_many :events, Discuss.Events
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:numeroCancha, :numeroJugadores, :descripcion])
    |> validate_required([:numeroCancha, :numeroJugadores])

  end


end
