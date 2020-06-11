defmodule Discuss.Events do
  use Discuss.Web, :model

  schema "events" do

    field :title, :string
    field :startDate, Ecto.Date
    field :startTime, Ecto.Time
    field :endDate, Ecto.Date
    field :endTime, Ecto.Time
    field :color, :string
    belongs_to :cancha, Discuss.Cancha
    belongs_to :jugador, Discuss.Jugador

  end

  def changeset(struct, params \\ %{}) do

    struct
    |> cast(params, [:title, :startDate, :startTime, :endDate, :endTime, :color])
    |> validate_required([:title, :startDate, :startTime, :endDate, :endTime, :color])

  end


end
