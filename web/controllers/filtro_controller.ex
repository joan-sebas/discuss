defmodule Discuss.FiltroController do
  use Discuss.Web, :controller

alias Discuss.Events

def index(conn, _params) do
  reserva = Events.changeset(%Events{}, %{})
  render conn, "index.html", reserva: reserva
end

def buscar(conn,%{"events"=> reserva}) do
 %{"startTime"=> startTime, "endTime"=> endTime}=reserva
    busqueda= Repo.all(Events)
    IO.puts("+++++++++++++++")
    IO.inspect(busqueda)
    render conn, "buscar.html", startTime: startTime, endTime: endTime , busqueda: busqueda
end

end
