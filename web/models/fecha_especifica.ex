defmodule Discuss.Fecha_especifica do
  use Discuss.Web, :model

  schema "fecha_especifica" do
    field :fechaEspecifica, :date
    field :horaApertura, :time
    field :horaCierre, :time
    field :precio, :float
    belongs_to :cancha, Discuss.Cancha

  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:fechaEspecifica, :horaApertura, :horaCierre, :precio])
    |> validate_required([:fechaEspecifica, :horaApertura, :horaCierre, :precio])

  end


end
