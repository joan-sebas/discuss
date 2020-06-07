defmodule Discuss.Fecha_especifica do
  use Discuss.Web, :model

  schema "fecha_especifica" do
    field :fechaEspecifica, Ecto.Date
    field :horaApertura, Ecto.Time
    field :horaCierre, Ecto.Time
    field :precio, :float
    belongs_to :cancha, Discuss.Cancha

  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:fechaEspecifica, :horaApertura, :horaCierre, :precio])
    |> validate_required([:fechaEspecifica, :horaApertura, :horaCierre, :precio])

  end


end
