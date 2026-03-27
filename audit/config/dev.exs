import Config

config :audit, Audit.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "audit_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
