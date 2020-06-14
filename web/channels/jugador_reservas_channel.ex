defmodule Discuss.Jugador_reservasChannel do
  use Discuss.Web, :channel
  alias Discuss.{Reserva, Jugador_cancha, Cancha, Jugador, Events}

  def join("jugador_reservas:" <> cancha_id, _params, socket) do
      user_id = socket.assigns.user_id
    cancha_id = String.to_integer(cancha_id)
    cancha = Cancha
      |> Repo.get(cancha_id)
      |> Repo.preload(events: [:jugador])


    {:ok, %{events: cancha.events, user: user_id}, assign(socket, :cancha, cancha)}
  end

  def handle_in(name, %{"startDate" => startDate, "startTime" => startTime, "agregar" => agregar},  socket) do


    count=
    IO.puts("´´´´´´´´´´´´´´´´´´´´")
    IO.inspect(count)
    user_id = socket.assigns.user_id
    jugador = Repo.get_by(Jugador, usuario_id: user_id)
    cancha = socket.assigns.cancha
    if agregar do

      changeset=[cancha, jugador]
        |> Enum.reduce(%Events{}, fn (link_to, person) ->
              build_assoc(link_to, :events, person)

            end)
  case Repo.one(from(p in Events, where: p.startDate == ^startDate and p.startTime == ^startTime  ,select: count("*"))) do
        0->

            changeset=  Events.changeset(changeset, %{startDate: startDate, startTime: startTime, estado: false})

        case Repo.insert(changeset) do
            {:ok, event} ->
                broadcast!(socket, "jugador_reservas:#{socket.assigns.cancha.id}:new",
                  %{event: event, user: user_id }

                    )
            {:reply, :ok, socket}
                {:error, _reason} ->
                  {:reply, {:error, %{errors: cancha}}, socket}
          end
        1->
            changeset=  Events.changeset(changeset, %{startDate: startDate, startTime: startTime, estado: false})

        case Repo.insert(changeset) do
            {:ok, event} ->
                broadcast!(socket, "jugador_reservas:#{socket.assigns.cancha.id}:new",
                  %{event: event, user: user_id }

                    )
            {:reply, :ok, socket}
                {:error, _reason} ->
                  {:reply, {:error, %{errors: cancha}}, socket}
          end
         2->
            {:reply, {:error, %{errors: cancha}}, socket}
       end

    else

       from(x in Events, where: x.startDate == ^startDate and x.startTime == ^startTime and x.jugador_id== ^jugador.id  ) |> Repo.delete_all
       broadcast!(socket, "jugador_reservas:#{socket.assigns.cancha.id}:new",
         %{user: user_id }

           )
              {:reply, :ok, socket}

    end
  end
end
