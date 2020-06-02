# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "S4abdl7yPF3iTqgZS/tN7Tjxg9Nj2m670fncN0xq8eUZ7enHqsRsDH8ELbgGRL0E",
  render_errors: [view: Discuss.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth,
  providers: [
      github: { Ueberauth.Strategy.Github, [default_scope: "user,user:email,public_repo"]}
    ]

config  :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "78c8041e4dd75cfe80c4",
  client_secret: "0c9c8985d8e22be4aa98dc8a65eb51a4b705aa2a"
