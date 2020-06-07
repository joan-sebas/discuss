defmodule Discuss.AutenController do
  use Discuss.Web, :controller


  alias Discuss.Usuario




  def index(conn, _params) do
    render conn, "index.html"
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: auten_path(conn, :index))
  end
  def signin(conn, changeset) do
    case comprobar_user(changeset) do
      {:ok, usuario} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:usuario_id, usuario.id)
        |> redirect(to: match_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: auten_path(conn, :index))
    end
  end
  defp comprobar_user(  %{"nickname" => nickname}) do

    case Repo.get_by(Usuario, nickname ) do
      nil ->
          {:error, "_reason"}
      usuario ->
        {:ok, usuario}
    end
  end
  def new(conn, _params) do
    changeset = Usuario.changeset(%Usuario{}, %{})
    rol=""
    render conn, "new.html", changeset: changeset, rol: rol
  end
  def create(conn, changeset, rol) do

    changeset =  Ecto.Changeset.put_change(changeset, :rol, rol)
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Usuario Creado")
        |> redirect(to: auten_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset, rol: rol
    end
  end

end
