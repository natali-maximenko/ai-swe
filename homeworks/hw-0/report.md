# Homework 0 Report

Этот файл для фиксации работы над кодом проекта.

## Log example

- Date:
- Task:
- Changes:
- Notes:

### РП 1 - Проект на эликсир + экто

Date: 27.03.2026
Task: РП 1

Changes:
```
Сделала РП 1 внутри ai-swe в подпапке audit и довела до рабочего состояния.

Что выполнено:

Создан проект: audit/ через mix new audit --sup
Подключены зависимости в audit/mix.exs:
- ecto_sql
- postgrex
Добавлен Repo:
- audit/lib/audit/repo.ex
Repo добавлен в supervision tree:
- audit/lib/audit/application.ex
Добавлены конфиги:
- audit/config/config.exs
- audit/config/dev.exs
- audit/config/test.exs
Проверка выполнена:
- mix deps.get
- mix compile — успешно
Обновлён WORKPLAN.md:
- РП 1 отмечен как done
```
Notes:

Всё чётко, после первого запроса, уточняет в какой папке развернуть проект в корне или отдельно, предлагает название. Название чуть поменяли. Проверки "что проект живой" предлагает сам агент. Сразу предлагает проставить статус в рабочем плане. Сделал всё по шагам, статус задачи обновил. 
Вывел саммари, сразу предложил следующий инкремент.

### РП 2 - Добавить базовую audit-таблицу и schema

Date: 30.03.2026
Task: РП 2

Changes:

1. Создаю specs/wp-2-migration-schema.md с описанием РП 2, согласованным с WORKPLAN.md и PROJECT.md.
Внутри: связь с РП 2 из WORKPLAN.md, цель и границы, предлагаемые колонки для audit_events (operation, entity_type, entity_id, actor_id, metadata, payload, время события), критерии готовности (миграция, schema, тест с Repo.insert/чтение), отсылка к PROJECT.md. Префикс wp- в имени файла совпадает с «рабочими продуктами» из вашего плана.

2. Готово, обновил ai-swe/specs/wp-2-migration-schema.md по твоим пунктам:
- убрал actor_id (зафиксировал, что актор уходит в metadata);
- id сменил на uuid;
- убрал occurred_at, добавил использование системного inserted_at через timestamps(updated_at: false, type: :utc_datetime_usec);
- operation и entity_type сменил с text на varchar;
- в индексе времени теперь ориентир на inserted_at вместо occurred_at.
Если хочешь, следующим шагом сразу применю эти же решения уже в коде миграции и schema внутри audit.

3. Добавлю в spec отдельный блок с требованиями к миграции (публичный интерфейс Audit.Migrations.up/down) и отмечу, что пошаговое подключение нужно вынести в README библиотеки.

Если хочешь, дальше сразу оформлю черновик этого README-раздела (installation + migration setup) в самом ai-swe/README.md.

4. Сделал все 3 шага по РП-2 последовательно: миграция → schema → README.

Миграция и интерфейс библиотеки

добавил публичный модуль Audit.Migrations в ai-swe/audit/lib/audit/migrations.ex
up/0 создаёт audit_events с:
id как :binary_id (UUID)
operation, entity_type как :string
entity_id как :text
metadata (:map, default %{}), payload (:map)
timestamps(updated_at: false, type: :utc_datetime_usec) → только inserted_at
индексы по [:entity_type, :entity_id] и [:inserted_at]
добавил миграцию-обёртку ai-swe/audit/priv/repo/migrations/20260330120000_add_audit_table.exs, где:
up вызывает Audit.Migrations.up()
down вызывает Audit.Migrations.down()

Schema

добавил Audit.AuditEvent в ai-swe/audit/lib/audit/audit_event.ex
UUID primary key (Ecto.UUID, autogenerate), поля согласованы с таблицей
timestamps(updated_at: false) для inserted_at-only
README

обновил ai-swe/audit/README.md
добавил пошаговое подключение для consumer-проекта:
mix ecto.gen.migration add_audit_table
вставка Audit.Migrations.up/down
mix ecto.migrate

Проверка

выполнил mix format && mix test в ai-swe/audit
тесты зелёные (0 failures)
есть сообщения Postgrex про отсутствие audit_test в локальной БД, но это не завалило текущие тесты
линтер-диагностика по изменённым файлам — чисто
Если хочешь, следующим шагом сделаю отдельный минимальный интеграционный тест именно на Audit.AuditEvent через Repo.insert/Repo.get (как в критериях spec).

5. Принял. Сейчас поправлю шаг 1 (уберу индексы и зафиксирую id как null: false) и шаг 2 (добавлю changeset/2 с обязательными полями для вставки), затем прогоню формат/тесты.

6. Добавлю минимальные тесты без зависимости от поднятой БД: проверка changeset (валидный/невалидный набор полей) и проверка наличия публичного интерфейса Audit.Migrations.up/0 и down/0

Вот тут уже началась ерунда, потому что я дала очень общее описание. И полезной нагрузки от таких тестов нет, но там даже что-то в процессе агент сам правил, потому что с первого раза не завелось.

7. Сделаю: удалю тест миграций и добавлю один интеграционный тест для schema ровно под критерий №3 — Repo.insert + чтение по id. Сначала проверю текущую тестовую конфигурацию Repo.

Тут в общем тоже начились странные манипуляции с тестами, я сказала "стоп". Потому что у нас не настроен проект по обычным правилам для тестирования.

8. В ai-swe/audit/mix.exs добавлен такой же блок aliases: setup, ecto.setup, ecto.reset, переопределённый test.
Дополнительно (чтобы интеграционный тест с Repo работал предсказуемо):
в test/test_helper.exs — Ecto.Adapters.SQL.Sandbox.mode(Audit.Repo, :manual);
test/audit_event_test.exs упрощён: без setup_all с мигратором — миграции ожидаются от mix test (алиас).
Локально нужны запущенный PostgreSQL и учётные данные из config/test.exs; первый раз достаточно mix test (или явно mix setup для dev). В среде, где Mix спрашивает про установку Hex, для CI/скриптов используют неинтерактивно: mix local.hex --force перед mix test.

9. Создан файл ai-swe/docker-compose.yml:

образ postgres:16-alpine;
POSTGRES_USER / POSTGRES_PASSWORD: postgres / postgres — как в audit/config/dev.exs и audit/config/test.exs;
порт 5432:5432 (хост localhost для Ecto);
том postgres_data для данных;
healthcheck через pg_isready.
Базы audit_dev и audit_test по-прежнему создаёт mix ecto.create (у вас это уже в алиасах перед тестами). Запуск из корня репо: docker compose up -d.

10. Из корня ai-swe контейнер уже поднят: docker compose up -d отработал успешно (ai-swe-postgres-1 в статусе Started).

Тесты
Первый прогон mix test в этой среде остановился на вопросе про установку Hex; дальше выполнено mix local.hex --force и mix local.rebar --force, затем снова mix test.

При накате миграций всплыло отсутствие Jason: для колонки metadata с default: %{...} Ecto при генерации DDL вызывает Jason.encode_to_iodata!/1. В audit/mix.exs добавлена зависимость {:jason, "~> 1.4"}, после mix deps.get миграции и тесты проходят.

Результат: 1 doctest, 2 tests, 0 failures (видны реальные INSERT/SELECT по audit_events).

11. Обновляем статус РП 2 и спеки, затем выполняем git pull --rebase, коммит и push в репозитории ai-swe.

Notes:

Теряется контекст и у меня и у агента, когда некие действия откладываются. Типа на каких-то шагах были предложения поправить ридми или дописать тест. Там что именно писать в тесте агенту было понятно, но я отложила эту задачу. А потом говорю, напиши тест, потому что уверена, что понятно что там делать, ты ж мне сам пару шагов раньше нормально предлагал. 

Дальше с тестами, я забыла, что один раз на проекте эту часть инфры тоже надо развернуть и агент не знает, как у нас её принято разворачивать. А раз этого нет, там начинаются фантазии в стиле "делаем что можем с тем что имеем".

В целом наверное все кодерские забеги стоило бы ограничить: делай раз - спроси меня как мне результат, если столкнёшься с ошибкой, тоже спроси меня что с ней делать, только потом делай два

12. Закоммитить и запушить файлы `homeworks/hw-0` по РП 2 (checklist, prompt, report).