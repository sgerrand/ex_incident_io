# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- Setup: `mix setup`
- Run all tests: `mix test`
- Run single test: `mix test path/to/test_file.exs:line_number`
- Run specific test file: `mix test path/to/test_file.exs`
- Format code: `mix format`
- Lint: `mix credo`
- Coverage: `mix coveralls`

## Architecture

This is an Elixir HTTP client library for the incident.io API, published as the `incident_io` hex package.

### Request pipeline

`IncidentIo` (the root module, `lib/incident_io.ex`) owns the HTTP layer. All resource modules `import IncidentIo` to get `get/3`, `post/3`, `put/3`, and `delete/3`. These delegate through `_request/4` → `json_request/5` → `raw_request/5`, which calls `Req.request!()`. The stub name for `Req.Test` is `:incident_io`.

Responses are always returned as `{status_code, decoded_body, %Req.Response{}}` tuples. The body is decoded via `IncidentIo.Json` (a behaviour backed by Jason, swappable via `Application.put_env(:incident_io, :json_module, ...)`).

### Resource modules

Each API resource lives in `lib/incident_io/<resource>_v<n>.ex` (e.g. `IncidentIo.IncidentsV2`). Resources expose a consistent set of functions — typically `list/2`, `show/2`, `create/2`, `update/3`, `delete/2` — all accepting a `%IncidentIo.Client{}` as the first argument. The `Client` struct holds the API key (`auth: %{api_key: "..."}`) and the base endpoint URL (defaults to `https://api.incident.io/`).

### Pagination

`IncidentIo.Pagination.stream/3` wraps any `list/2` function in a lazy `Stream` that follows cursor-based pagination automatically via the `pagination_meta.after` field.

### Testing

Tests use `IncidentIo.TestCase` (`test/support/test_case.ex`), which wires up `Req.Test` stubs and a `Mox`-backed `IncidentIo.Json.Mock`. Each test file stubs `Req.Test.stub(:incident_io, fn conn -> ... end)` in a `setup` block to return canned JSON responses. Test files mirror the lib structure: `test/<resource>_v<n>_test.exs`.

## Code Style

- API modules use `@typep` for private request/response shape types; keep them close to the functions that use them.
- Use `import IncidentIo` in resource modules (not `alias`) — the HTTP helpers are designed to be imported.
- Validate enum-like params against predefined lists; use atoms for internal values.
- Branch naming: `feature-description-ticket-id`

At the end of every change, update CLAUDE.md with anything useful that would have been helpful at the start.
