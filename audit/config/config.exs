import Config

config :audit,
  ecto_repos: [Audit.Repo]

import_config "#{config_env()}.exs"
