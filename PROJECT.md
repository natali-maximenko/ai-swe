---
type: doc
status: draft
created: 2026-03-26
updated: 2026-03-26
---

# PROJECT: audit

## Purpose

`audit` is a software project to build an Elixir library for auditing entity changes at the database level.

The setup layer (`mise`, `Makefile`, `SETUP.md`) is only development infrastructure. It is not the product goal.

## Repository Type

This repository is a `DS/instrument` repository:

- source-of-truth for domain knowledge is external (`Pack`);
- this repository stores executable code, tests, setup logic, and operational docs for the library.

## Current Scope

Primary product scope:

- design and implement a reusable audit library for DB-level entity change tracking;
- provide integration primitives for Elixir applications;
- define stable API for writing and querying audit records.

Current infrastructure scope:

- install local tools (`make cursor`);
- verify environment (`make check`);
- provide optional extras (`make extras`, `make cursor-cli`).

## Product Definition

The product is a library that captures and persists entity change events at the DB boundary.

Expected outcomes:

- consistent audit trail for create/update/delete operations;
- reliable metadata for "who changed what and when";
- queryable history for compliance, debugging, and operational investigations;
- minimal coupling to a specific app domain.

## Core Use Cases

- compliance and internal controls;
- debugging data regressions and incident analysis;
- reconstruction of entity timeline and field-level diffs;
- operational observability around state changes.

## Architecture Direction (Draft)

- Elixir-first implementation;
- DB-level guarantees for audit persistence;
- explicit extension points for app-level actor/context metadata;
- clear separation between audit capture, storage, and read/query API.

## Core Toolchain (Development Infrastructure)

Core tools are defined in `mise.toml` and currently include:

- `direnv`
- `gh`
- `gitleaks`
- `jq`
- `port-selector`
- `erlang`
- `elixir`
- `node`

## Entry Points

Product development:

- library code and tests (to be expanded as implementation progresses)

Environment/bootstrap:

- `make cursor` — bootstrap core environment
- `make check` — validate Cursor/Elixir setup
- `make extras` — install optional `tmux` and `zellij`
- `make cursor-cli` — install Cursor CLI
- `make ai` — optional legacy AI setup
- `make check-ai` — optional legacy AI checks

## Non-Goals

- not another generic setup-only repository;
- not a business-domain-specific audit implementation tightly coupled to one app;
- not mandatory dependence on Claude/Codex integrations in the default development path.

## Working Agreement

When updating this project:

1. Product decisions take priority over setup convenience.
2. Setup changes must remain minimal, Linux-friendly, and opt-in where possible.
3. `SETUP.md` documents infrastructure, while `PROJECT.md` documents product intent.
