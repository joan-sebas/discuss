defmodule Discuss.Events do
  use Discuss.Web, :model

  schema "events" do
@derive {Poison.Encoder, only: [:title, :startDate, :startTime, :endDate, :endTime, :color, :estado]}
    field :title, :string
    field :startDate, Ecto.Date
    field :startTime, Ecto.Time
    field :endDate, Ecto.Date
    field :endTime, Ecto.Time
    field :color, :string
    field :edit, :boolean
    field :estado, :boolean
    belongs_to :cancha, Discuss.Cancha
    belongs_to :jugador, Discuss.Jugador

  end

  def changeset(struct, params \\ %{}) do

    struct
    |> cast(params, [:startDate, :startTime, :color, :edit, :estado])
    |> validate_required([ :startDate, :startTime, :estado])

  end


end
