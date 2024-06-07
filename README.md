# incident_io

An Elixir client for the [incident.io API](https://api-docs.incident.io/).

[![Build Status](https://github.com/sgerrand/ex_incident_io/workflows/CI/badge.svg)](https://github.com/sgerrand/ex_incident_io/actions)
[![Hex.pm](https://img.shields.io/hexpm/v/incident_io.svg)](https://hex.pm/packages/incident_io)
[![Documentation](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/incident_io/)

## Installation

Add `:incident_io` to the dependencies in your project's `mix.exs`:

```elixir
def deps do
  [
    {:incident_io, "~> 0.1"}
  ]
end
```

## Running tests
Clone the repository and fetch its dependencies:
```shell
$ git clone https://github.com/sgerrand/ex_incident_io.git
$ cd ex_incident_io
$ mix deps.get
$ mix test
```
