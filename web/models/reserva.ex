defmodule Discuss.Reserva do
  use Discuss.Web, :model

  schema "reserva" do
    field :fechaHora, Ecto.DateTime
    field :estado, :boolean
    belongs_to :cancha, Discuss.Cancha
  
    timestamps()

  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:fechaHora, :estado])
    |> validate_required([:fechaHora, :estado])

  end


end
