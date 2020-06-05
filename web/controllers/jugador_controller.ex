defmodule Discuss.JugadorController do
  use Discuss.Web, :controller

  alias Discuss.Jugador
  alias Discuss.Usuario

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  plug :put_layout, :nested_layout when action not in [:edit]
  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, %{"jugador" => jugador , "usuario" => jugador}) do
    changeset = conn.assigns.user
    |> build_assoc(:topics)
    |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
        {:error, changeset} ->
          render conn, "new.html", changeset: changeset
        end
      end
    def create_Usuario(conn, %{"usuario" => usuario ) do
      case Repo.get_by(Usuario, email: changeset.changes.email) do
        nil ->
          Repo.insert(changeset)
        user ->
          {:ok, user}
      end

          end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id)
    render conn, "show.html", topic: topic
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end


  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end
end
