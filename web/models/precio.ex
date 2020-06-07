defmodule Discuss.Precio do
  use Discuss.Web, :model

  schema "precio" do
    field :horaDesde, Ecto.Time
    field :horaHasta, Ecto.Time
    belongs_to :horario, Discuss.Horario
    belongs_to :dia, Discuss.Dia

  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:horaDesde, :horaHasta])
    |> validate_required([:horaDesde, :horaHasta])

  end


end
