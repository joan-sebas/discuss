defmodule Discuss.Establecimiento do
  use Discuss.Web, :model

  schema "establecimiento" do
    field :nombre, :string
    field :direccion, :string
    field :telefono, :string
    belongs_to :usuario, Discuss.Usuario
    has_many :cancha, Discuss.Cancha
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:nombre, :direccion, :telefono])
    |> validate_required([:nombre, :direccion, :telefono])

  end


end
