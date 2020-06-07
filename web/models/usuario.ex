defmodule Discuss.Usuario do
  use Discuss.Web, :model

  schema "usuario" do
    field :nickname, :string
    field :rol, :string
    field :contraseña, :string
    has_many :jugador, Discuss.Jugador
    has_many :establecimiento, Discuss.Establecimiento
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    
    struct
    |> cast(params, [:nickname, :rol, :contraseña])
    |> validate_required([:nickname, :rol, :contraseña])

  end


end
