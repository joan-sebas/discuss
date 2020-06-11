defmodule Discuss.EventsController do
  use Discuss.Web, :controller
  alias Discuss.Events

def index(conn, _params) do
    events = Repo.all(Events)
    render conn, "index.json", events: events
  end
end
