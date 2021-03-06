defmodule Discuss.Jugador do
  use Discuss.Web, :model
@derive {Poison.Encoder, only: [:nombre]}
  schema "jugador" do
    field :nombre, :string
    field :apellido, :string
    field :celular, :string
    field :fechaNac, Ecto.Date
    field :posicion, :string
    field :piernaBuena, :string
    belongs_to :usuario, Discuss.Usuario
    has_many :events, Discuss.Events
    has_many :jugador_equipo, Discuss.Jugador_equipo
    has_many :equipo, Discuss.Equipo
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:nombre, :apellido, :celular, :fechaNac, :posicion, :piernaBuena])
    |> validate_required([:nombre, :posicion])

  end


end
