defmodule Discuss.AutenController do
  use Discuss.Web, :controller


  alias Discuss.Usuario




  def index(conn, _params) do

    if conn.assigns.user do
        redirect(conn, to: match_path(conn, :index))

    else
      changeset = Usuario.changeset(%Usuario{}, %{})
        render conn, "index.html", changeset: changeset
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: auten_path(conn, :index))
  end

  def signin(conn, %{"usuario" => usuario}) do
    param = Map.put(usuario, "rol", "jugador")

    case comprobar_user(param) do
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

  defp comprobar_user(%{"nickname" => nickname, "contraseña" => contraseña}) do

    case Repo.get_by(Usuario, nickname: nickname) do
      nil ->
          {:error, "_reason"}
      usuario ->
        if usuario.contraseña==contraseña do

          {:ok, usuario}
        else
          {:error, "No coincide la contraseña"}
        end
    end
  end
  def new(conn, _params) do
    if conn.assigns.user do
        redirect(conn, to: match_path(conn, :index))

    else
    changeset = Usuario.changeset(%Usuario{}, %{})

    render conn, "new.html", changeset: changeset
    end
  end
  def create(conn, %{"usuario" => usuario}) do

    param = Map.put(usuario, "rol", "jugador")
    changeset=Usuario.changeset(%Usuario{}, param)



    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Usuario Creado")
        |> redirect(to: auten_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

end
