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
