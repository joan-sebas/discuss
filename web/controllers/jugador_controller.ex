defmodule Discuss.JugadorController do
  use Discuss.Web, :controller

  alias Discuss.Jugador
  alias Discuss.Usuario

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]


  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, _params) do
    changeset = Jugador.changeset(%Jugador{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"jugador" => jugador}) do
    changeset = conn.assigns.user
      |> build_assoc(:jugador)
      |> Jugador.changeset(jugador)

    case Repo.insert(changeset) do
      {:ok, _jugador} ->
        conn
        |> put_flash(:info, "Jugador Creado")
        |> redirect(to: jugador_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

end
