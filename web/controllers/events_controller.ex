defmodule Discuss.EventsController do
  use Discuss.Web, :controller
  alias Discuss.Events
  alias Discuss.Jugador

def index(conn, _params) do

    %{"user" => id}=  conn.params
    jugador = Repo.get_by(Jugador, usuario_id: id )
    list=[]
    events = Repo.all(Events)
    gg=Enum.map(events, fn x ->
      if x.jugador_id == jugador.id do

      x
      |> Map.put(:color, "#257e4a")
      |> Map.put(:edit, true)
      else
      x |> Map.put(:edit, false)


      end

        end)
    
    render conn, "index.json", events: gg
  end
end
