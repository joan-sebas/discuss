defmodule Discuss.MatchController do
  use Discuss.Web, :controller

alias Discuss.Cancha


  plug Discuss.Plugs.RequireAuth when action in [:index, :show, :create, :edit, :update, :delete]

  def index(conn, _params) do
    
    render conn, "index.html"
  end
  def calendar(conn, %{"start" => start_date, "end" => end_date} = _params) do
    data =
      AppointmentsContext.fetch_appointments(start_date, end_date)
      |> AppointmentsConverter.convert()
    # instead of render and a view, use json to a quick json serializing and return
    json(conn, data)

  end
  def show(conn, %{"id" => reserva_id}) do
    reserva = Repo.get!(Cancha, reserva_id)
    render conn, "show.html", reserva: reserva
  end

end
