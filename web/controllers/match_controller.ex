defmodule Discuss.MatchController do
  use Discuss.Web, :controller




  plug Discuss.Plugs.RequireAuth when action in [:index, :new, :create, :edit, :update, :delete]

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

end
