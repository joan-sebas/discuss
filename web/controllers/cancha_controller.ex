defmodule Discuss.CanchaController do
  use Discuss.Web, :controller

  alias Discuss.Cancha
  alias Discuss.Establecimiento
  alias Discuss.Usuario

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]


  def index(conn, _params) do
    establecimiento = Repo.get_by(Establecimiento, usuario_id: conn.assigns.user.id)
    cancha = Repo.all(Cancha)
    render conn, "index.html", cancha: cancha, establecimiento: establecimiento
  end


  def show(conn, %{"id" => cancha_id}) do
    cancha = Repo.get!(Cancha, cancha_id)
    render conn, "show.html", cancha: cancha
  end

  def new(conn, _params) do
    changeset = Cancha.changeset(%Cancha{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"cancha" => cancha}) do
    changeset = Repo.get_by(Establecimiento, usuario_id: conn.assigns.user.id)
      |> build_assoc(:cancha)
      |> Cancha.changeset(cancha)

    case Repo.insert(changeset) do
      {:ok, _cancha} ->
        conn
        |> put_flash(:info, "Cancha Creada")
        |> redirect(to: cancha_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => cancha_id}) do
    cancha = Repo.get(Cancha, cancha_id)
    changeset = Cancha.changeset(cancha)

    render conn, "edit.html", changeset: changeset, cancha: cancha
  end

  def update(conn, %{"id" => cancha_id, "cancha" => cancha}) do
    old_cancha = Repo.get(Cancha, cancha_id)
    changeset = Cancha.changeset(old_cancha, cancha)

    case Repo.update(changeset) do
      {:ok, _cancha} ->
        conn
        |> put_flash(:info, "Cancha Modificada")
        |> redirect(to: cancha_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, cancha: old_cancha
    end
  end

  def delete(conn, %{"id" => cancha_id}) do
    Repo.get!(Cancha, cancha_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Cancha Eliminada")
    |> redirect(to: cancha_path(conn, :index))
  end

end
