See [PROJECT.md](PROJECT.md) for project description.

## Stack
Elixir, Erlang/OTP, PostgreSQL (target), ExUnit

## Key commands
- `mix ecto.migrate` — run migrations
- `mix test` — run tests
- `iex -S mix` — run interactive console

## Conventions
- Elixir project without Phoenix
- ExUnit for tests
- ExMachina for factories
- Add new libraries only when needed

## Constraints
- Don't touch existing migrations
- Don't implement auth