defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Discuss.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack


   get "/", MatchController, :index
   get "/match/calendar", MatchController, :calendar
   get "/match/:id", MatchController, :show

  #  get "/topics/new", TopicController, :new
  #  post "/topics", TopicController, :create
  #  get "/topics/:id/edit", TopicController, :edit
  #  put "/topics/:id", TopicController, :update
    #resources "/", MatchController #simplifica todo lo de arriba

  end
  scope "/topic", Discuss do
    pipe_through :browser # Use the default browser stack

  #  get "/", TopicController, :index
  #  get "/topics/new", TopicController, :new
  #  post "/topics", TopicController, :create
  #  get "/topics/:id/edit", TopicController, :edit
  #  put "/topics/:id", TopicController, :update
    resources "/", TopicController #simplifica todo lo de arriba

  end

  scope "/auth", Discuss do
    pipe_through :browser

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback


  end

  scope "/auten", Discuss do
    pipe_through :browser
    get "/signout", AutenController, :signout
    post "/signin", AutenController, :signin
    get "/", AutenController, :index
    get "/new", AutenController, :new
    post "/autens", AutenController, :create


  end
  scope "/jugador", Discuss do
    pipe_through :browser
  get "/", JugadorController, :index
  get "/new", JugadorController, :new
  post "/create", JugadorController, :create

  end

  scope "/equipo", Discuss do
    pipe_through :browser
  resources "/", EquipoController

  end

  scope "/establecimiento", Discuss do
    pipe_through :browser
  resources "/", EstablecimientoController

  end

  scope "/cancha", Discuss do
    pipe_through :browser
  resources "/", CanchaController

  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
