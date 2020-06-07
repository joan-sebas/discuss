defmodule Discuss.MatchController do
  use Discuss.Web, :controller




  plug Discuss.Plugs.RequireAuth when action in [:index, :new, :create, :edit, :update, :delete]
  plug :put_layout, :nested_layout when action not in [:edit]
  def index(conn, _params) do


    render conn, "index.html"
  end

end
