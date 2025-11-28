# Repository Guidelines

## Project Structure & Module Organization
- Source: `src/` (VM in `src/vm/`, standard library in `src/library/`, helpers in `src/helpers/`).
- Entry point: `src/arturo.nim`.
- Tests: `tests/` (unit tests in `tests/unittests/`, error cases in `tests/errors/`).
- Tools & scripts: `tools/` (test runner, docs, benchmarking).
- Binaries: `bin/` (created on build). Docs and examples live in `docs/` and `examples/`.

## Build, Test, and Development Commands
- `./build.nims` — Build the Arturo binary to `bin/arturo` (default full build).
- `./build.nims --mode:mini` — Build a smaller “mini” release.
- `./build.nims --mode:web` — Build a JS/Web target.
- `./build.nims --install` — Install to `~/.arturo/bin`.
- `./build.nims test` — Run the test suite (uses `tools/tester.art`).
- `./build.nims docs` — Generate developer docs under `dev-docs/`.
- Example: `./build.nims --who:dev --log --mode:full` for a verbose dev build.

## Coding Style & Naming Conventions
- Language: Nim. Indent with 4 spaces; keep lines readable.
- Modules/files: lowercase (e.g., `parse.nim`, `exec.nim`).
- Types/consts: `PascalCase` (export with `*` when public).
- Procs/vars: `camelCase` (export with `*`).
- Prefer existing patterns in `src/vm/` and `src/library/`. No trailing whitespace; keep imports minimal.

## Testing Guidelines
- Primary runner: `./build.nims test` (wraps `tools/tester.art`).
- Test pattern: pair an `.art` script with a matching `.res` expected output in `tests/unittests/` (e.g., `strings.art` + `strings.res`).
- Skips are handled by the runner based on build mode; aim for deterministic output.
- Optional Unitt config exists (`unitt.toml`) for the external `unitt` tool.

## Commit & Pull Request Guidelines
- Commits: imperative mood, concise subject; reference issues (e.g., `Fixes #123`). Group related changes; include tests/docs when applicable.
- PRs: follow `.github/pull_request_template.md`. Provide a clear description, scope (type checkboxes), linked issues, and screenshots/logs when relevant.
- Requirements: green CI across platforms, tests updated, no unrelated refactors. Branch from `master`.

## Security & Configuration Tips
- Prereqs: Nim toolchain and a C/C++ compiler. Some features depend on system libs (e.g., SSL, WebKit on Linux).
- Use `--log` when troubleshooting builds and `--mode:mini` when minimization is needed.
