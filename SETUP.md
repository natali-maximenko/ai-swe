# Базовый setup для Cursor + Elixir

Этот файл — каноническая bootstrap-инструкция для `ai-swe` и проектов, созданных на его основе.

Основной сценарий здесь — разработка в Cursor с Elixir-стеком. Legacy-поток под `claude-code/codex` сохранен отдельно и ставится только по явной команде.

## Быстрый старт

Подходит для Linux/macOS.

```bash
make cursor
```

`make cursor` выполняет:

1. установку `mise` (если еще нет);
2. установку core-инструментов из `mise.toml`;
3. подготовку базового локального окружения для Cursor + Elixir.

## Авторизация и shell

Обязательный логин после установки:

```bash
gh auth login
```

Затем настройте `direnv` hook для вашей shell и разрешите `.envrc`:

```bash
direnv allow
```

Документация: [direnv hooks](https://direnv.net/docs/hook.html)

## Проверка установки

```bash
make check
```

`make check` (скрипт `scripts/test-cursor-setup.sh`) проверяет:

- core toolchain: `mise`, `direnv`, `gh`, `gitleaks`, `jq`, `port-selector`;
- корректность `direnv`-экспорта `PORT`;
- Elixir toolchain: `erl`, `elixir`, `mix`.

Опциональные инструменты проверяются как `WARN`:

- `node`
- `cursor` (CLI)
- `tmux`
- `zellij`

## Что ставится автоматически (core)

Из `mise.toml` устанавливаются:

- `direnv`
- `gh`
- `gitleaks`
- `jq`
- `port-selector`
- `erlang`
- `elixir`
- `node`

## Опциональные команды

Установка Cursor CLI:

```bash
make cursor-cli
```

Установка локальных terminal extras:

```bash
make extras
```

Эта команда добавляет `tmux` и `zellij`, но они не ставятся по умолчанию.

## Legacy: AI agents flow (опционально)

Если нужен старый поток для `claude-code/codex`, используйте:

```bash
make ai
```

Проверка legacy-окружения:

```bash
make check-ai
```

Legacy-поток включает установку agent CLI, skills и Claude plugins/marketplaces и не требуется для Cursor-first работы.

## Что сохранить в производном проекте

Если вы делаете учебный/рабочий проект на базе этого репозитория, сохраните setup-инструкции в одном из файлов:

- `SETUP.md`
- `CONTRIBUTING.md`
- `docs/onboarding.md`

Минимально зафиксируйте:

- как поднять окружение;
- как пройти авторизацию CLI;
- как проверить результат через `make check`.

## direnv

В проекте используется `direnv`: `.envrc` подхватывает `.env` и `.env.local`, а если `PORT` не задан явно — назначает его через `port-selector`.

`make check` проверяет, что `direnv` экспортирует числовой `PORT`.
