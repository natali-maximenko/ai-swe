import Config

config :audit,
  ecto_repos: [Audit.Repo]

config :audit, Audit.Repo,
  migration_timestamps: [type: :utc_datetime_usec]

import_config "#{config_env()}.exs"
