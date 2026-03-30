# Audit

Elixir library for database-level audit events.

The library provides:

- storage schema (`Audit.AuditEvent`);
- migration interface (`Audit.Migrations.up/0`, `Audit.Migrations.down/0`).

## Installation

Add dependency in your app:

```elixir
def deps do
  [
    {:audit, "~> 0.1.0"}
  ]
end
```

## Setup in a consumer project

1. Generate an empty migration in your app:

```bash
mix ecto.gen.migration add_audit_table
```

2. Fill migration with calls to the library interface:

```elixir
defmodule MyApp.Repo.Migrations.AddAuditTable do
  use Ecto.Migration

  def up do
    Audit.Migrations.up()
  end

  def down do
    Audit.Migrations.down()
  end
end
```

3. Run migration:

```bash
mix ecto.migrate
```

