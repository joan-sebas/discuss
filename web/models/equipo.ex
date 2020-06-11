defmodule Discuss.Equipo do
  use Discuss.Web, :model

  schema "equipo" do
    field :nombre, :string
    field :iniciales, :string
    belongs_to :jugador, Discuss.Jugador
    has_many :jugador_equipo, Discuss.Jugador_equipo
      has_many :events, Discuss.Events
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:nombre, :iniciales])
    |> validate_required([:nombre, :iniciales])

  end


end
