defmodule Discuss.EquipoController do
  use Discuss.Web, :controller

  alias Discuss.Jugador
  alias Discuss.Equipo
  alias Discuss.Jugador_equipo

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]


  def index(conn, _params) do
    jugador = Repo.get_by(Jugador, usuario_id: conn.assigns.user.id)
    equipo = Repo.all(Equipo)
    render conn, "index.html" , equipo: equipo, jugador: jugador
  end

  def new(conn, _params) do
    changeset = Equipo.changeset(%Equipo{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def show(conn, %{"id" => equipo_id}) do
    equipo = Repo.get!(Equipo, equipo_id)
    render conn, "show.html", equipo: equipo
  end

  def create(conn, %{"equipo" => equipo}) do
    changeset = Repo.get_by(Jugador, usuario_id: conn.assigns.user.id)
      |> build_assoc(:equipo)
      |> Equipo.changeset(equipo)

    case Repo.insert(changeset) do
      {:ok, _equipo} ->
          conn
            |> put_flash(:info, "Equipo Creado")
            |> redirect(to: equipo_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => equipo_id}) do
    equipo = Repo.get(Equipo, equipo_id)
    changeset = Equipo.changeset(equipo)

    render conn, "edit.html", changeset: changeset, equipo: equipo
  end

  def update(conn, %{"id" => equipo_id, "equipo" => equipo}) do
    old_equipo = Repo.get(Equipo, equipo_id)
    changeset = equipo.changeset(old_equipo, equipo)

    case Repo.update(changeset) do
      {:ok, _equipo} ->
        conn
        |> put_flash(:info, "Equipo Modificado")
        |> redirect(to: equipo_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, equipo: old_equipo
    end
  end

  def delete(conn, %{"id" => equipo_id}) do
    Repo.get!(Equipo, equipo_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Equipo Eliminado")
    |> redirect(to: equipo_path(conn, :index))
  end

end
