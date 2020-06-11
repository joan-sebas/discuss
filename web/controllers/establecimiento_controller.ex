defmodule Discuss.EstablecimientoController do
  use Discuss.Web, :controller

  alias Discuss.Establecimiento
  alias Discuss.Usuario

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]


  def index(conn, _params) do
    establecimiento = Repo.all(Establecimiento)
    render conn, "index.html", establecimiento: establecimiento
  end

  def show(conn, %{"id" => establecimiento_id}) do
    establecimiento = Repo.get!(Establecimiento, establecimiento_id)
    render conn, "show.html", establecimiento: establecimiento
  end

  def new(conn, _params) do
    changeset = Establecimiento.changeset(%Establecimiento{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"establecimiento" => establecimiento}) do
    changeset = conn.assigns.user
      |> build_assoc(:establecimiento)
      |> Establecimiento.changeset(establecimiento)

    case Repo.insert(changeset) do
      {:ok, _establecimiento} ->
        conn
        |> put_flash(:info, "Establecimiento creado")
        |> redirect(to: establecimiento_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => establecimiento_id}) do
    establecimiento = Repo.get(Establecimiento, establecimiento_id)
    changeset = Establecimiento.changeset(establecimiento)

    render conn, "edit.html", changeset: changeset, establecimiento: establecimiento
  end

  def update(conn, %{"id" => establecimiento_id, "establecimiento" => establecimiento}) do
    old_establecimiento = Repo.get(Establecimiento, establecimiento_id)
    changeset = Establecimiento.changeset(old_establecimiento, establecimiento)

    case Repo.update(changeset) do
      {:ok, _establecimiento} ->
        conn
        |> put_flash(:info, "Establecimiento Modificado")
        |> redirect(to: establecimiento_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, establecimiento: old_establecimiento
    end
  end

  def delete(conn, %{"id" => establecimiento_id}) do
    Repo.get!(Establecimiento, establecimiento_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Establecimiento eliminado")
    |> redirect(to: establecimiento_path(conn, :index))
  end

end
