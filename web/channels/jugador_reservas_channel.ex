defmodule Discuss.Jugador_reservasChannel do
  use Discuss.Web, :channel
  alias Discuss.{Reserva, Jugador_cancha, Cancha, Jugador, Events}

  def join("jugador_reservas:" <> cancha_id, _params, socket) do
    cancha_id = String.to_integer(cancha_id)
    cancha = Cancha
      |> Repo.get(cancha_id)
      |> Repo.preload(events: [:jugador])

    {:ok, %{events: cancha.events}, assign(socket, :cancha, cancha)}
  end

  def handle_in(name, %{"fechaHora" => fechaHora}, socket) do
end 
end
