defmodule Discuss.JugadorController do
  use Discuss.Web, :controller

  alias Discuss.Jugador
  alias Discuss.Usuario

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  plug :put_layout, :nested_layout when action not in [:edit]
  def index(conn, _params) do
    render conn, "index.html"
  end


end
