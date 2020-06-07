defmodule Discuss.Dia do
  use Discuss.Web, :model

  schema "dia" do
    field :nombre, :string

    has_many :precio, Discuss.Precio

  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:nombre])
    |> validate_required([:nombre])
    
  end


end
