defmodule Discuss.Jugador_reservasChannel do
  use Discuss.Web, :channel
  alias Discuss.{Reserva, Jugador_reserva}

  def join("jugador_reservas:" <> reserva_id, _params, socket) do
    reserva_id = String.to_integer(reserva_id)
    reserva = Reserva
      |> Repo.get(reserva_id)
      |> Repo.preload(jugador_reserva: [:jugador])

    {:ok, %{jugador_reserva: reserva.jugador_reserva}, assign(socket, :reserva, reserva)}
  end

  def handle_in(name, %{"fechaHora" => fechaHora}, socket) do
    reserva = socket.assigns.reserva
    user_id = socket.assigns.user_id
    jugador = Repo.get_by(Jugador, user_id: user_id)
    changeset = reserva
      |> build_assoc(:jugador_reserva, jugador_id: jugador.id)
      |> Jugador_reserva.changeset(%{fechaHora: fechaHora})

    case Repo.insert(changeset) do
      {:ok, jugador_reserva} ->
        broadcast!(socket, "jugador_reservas:#{socket.assigns.reserva.id}:new",
          %{jugador_reserva: jugador_reserva}
        )
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
