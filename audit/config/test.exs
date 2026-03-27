import Config

config :audit, Audit.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "audit_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10
