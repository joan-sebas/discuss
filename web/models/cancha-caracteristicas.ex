defmodule Discuss.Cancha_caracteristicas do
  use Discuss.Web, :model

  schema "cancha_caracteristicas" do

    belongs_to :cancha, Discuss.Cancha
    belongs_to :caracteristicas, Discuss.Caracteristicas
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[])


  end

end
