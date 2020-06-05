defmodule Discuss.Jugador do
  use Discuss.Web, :model

  schema "jugador" do
    field :nombre, :string
    field :apellido, :string
    field :celular, :string
    field :fechaNac, :date
    field :posicion, :string
    field :piernaBuena, :string
    belongs_to :usuario, Discuss.Usuario
    has_many :jugador_reserva, Discuss.Jugador_reserva
    has_many :jugador_equipo, Discuss.Jugador_equipo
    has_many :equipo, Discuss.Equipo
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:nombre, :apellido, :celular, :fechaNac, :posicion, :piernaBuena])
    |> validate_required([:nombre, :fechaNac, :posicion])

  end


end
