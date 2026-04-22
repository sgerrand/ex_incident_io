# Development Guidelines

## Build/Test/Lint Commands

- Setup environment: `mix setup`
- Run all tests: `mix test`
- Run single test: `mix test path/to/test_file.exs:line_number`
- Run specific test file: `mix test path/to/test_file.exs`
- Format code: `mix format`

## Code Style Guidelines

- Follow Elixir conventions
- Use `@moduledoc` and `@doc` for documentation
- Use aliases for long module names
- Group imports at the top of modules
- Validate inclusions with predefined lists
- Extract reusable behavior with protocols/behaviors
- Use Ecto associations correctly (has_many, belongs_to)
- Handle errors with pattern matching
- Test with ExUnit, Mox for mocking
- Organize modules hierarchically (context/sub-context/entity)

## Git Flow

- Branch naming: `feature-description-ticket-id`
- PRs should include tests and documentation updates

At the end of every change, update CLAUDE.md with anything useful that would
have been helpful at the start.
