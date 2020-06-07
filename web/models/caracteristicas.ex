defmodule Discuss.Caracteristicas do
  use Discuss.Web, :model

  schema "caracteristicas" do
    field :nombre, :string
    has_many :cancha_caracteristics, Discuss.Cancha_caracteristicas

  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:nombre])
    |> validate_required([:nombre])

  end


end
