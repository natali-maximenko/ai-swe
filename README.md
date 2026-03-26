# AI SWE

AI Driven Development repository

We will develop Elixir library for auditing entity changes at the database level.

## What This Project Is

`ai-swe` is a product repository, not just a setup template.

Project goal: provide a reusable audit component that captures and persists change history for entities (`create/update/delete`) with reliable metadata about who changed what and when.

Primary value:

- compliance and internal controls;
- debugging and incident investigation;
- timeline reconstruction and change traceability.

Detailed project intent: see [PROJECT.md](PROJECT.md).

## Current Status

The repository currently contains:

- product intent and scope (`PROJECT.md`);
- development environment setup (`SETUP.md`);
- bootstrap/check automation (`Makefile`, `scripts/test-cursor-setup.sh`).

Implementation of the library itself is the next stage.

## Development Environment

Use the setup guide:

- [SETUP.md](SETUP.md)

Quick start:

```bash
make cursor
direnv allow
make check
```

Optional local tools:

```bash
make extras
make cursor-cli
```

## Principles

- Product decisions are primary; setup serves development.
- Default path should remain minimal and Linux-friendly.
- Optional and legacy integrations stay opt-in.
