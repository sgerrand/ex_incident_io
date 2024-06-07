# incident_io

An Elixir client for the [incident.io API](https://api-docs.incident.io/).

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
