defmodule Discuss.Horario do
  use Discuss.Web, :model

  schema "horario" do
    field :horaApertura, :time
    field :horaCierre, :time
    belongs_to :cancha, Discuss.Cancha
    belongs_to :precio, Discuss.Precio
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:horaApertura, :horaCierre])
    |> validate_required([:horaApertura, :horaCierre])

  end


end
