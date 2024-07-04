# incident_io

[![Build Status](https://github.com/sgerrand/ex_incident_io/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/sgerrand/ex_incident_io/actions/workflows/ci.yml)
[![Coverage Status](https://coveralls.io/repos/github/sgerrand/ex_incident_io/badge.svg?branch=main)](https://coveralls.io/github/sgerrand/ex_incident_io?branch=main)
[![Hex.pm](https://img.shields.io/hexpm/v/incident_io.svg)](https://hex.pm/packages/incident_io)
[![Documentation](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/incident_io/)

An Elixir client for the [incident.io API](https://api-docs.incident.io/).

With just a few lines of code you can begin interacting:

```elixir
Mix.install([
  {:incident_io, "~> 0.1"}
])

client = IncidentIo.Client.new(%{api_key: System.fetch_env!("INCIDENT_API_KEY")
IncidentIo.IncidentsV2.create(client, idempotency_key: "your-idempotency-key", visibility: :public)
```

## Requirements

You'll need an [incident.io](https://incident.io/) account to use this package.
[Sign up on their website](https://incident.io/) if you don't already have one.

## Installation

Add `:incident_io` to the dependencies in your project's `mix.exs`:

```elixir
def deps do
  [
    {:incident_io, "~> 0.1"}
  ]
end
```

## Getting started

You will need to create an API key via your [incident.io
dashboard](https://app.incident.io/settings/api-keys) to make requests. Please
note their warning message about the scope for this API key:

> When you create the key, you'll be able to choose what actions it can take for
> your account: choose carefully, as those roles can only be set when you first
> create the key.

Once you've created an API key then you're ready to start making requests.

## Example

Assuming that you've created and configured your incident.io API key as an
environment variable named `INCIDENT_API_KEY`, you can
create and read incidents as simply as the following example module:

```elixir
defmodule MyIncidentIo do
  use IncidentIo

  alias IncidentIo.Client
  alias IncidentIo.IncidentsV2

  def create(idempotency_key)
    IncidentsV2.create(client, idempotency_key: idempotency_key, visibility: :public)
  end

  def read(incident_id)
    IncidentsV2.show(client, incident_id)
  end

  defp client
    Client.new(%{api_key: System.fetch_env!("INCIDENT_API_KEY")
  end
end
```

## Development

To start working on this application, clone the repository and fetch its
dependencies:
```shell
git clone https://github.com/sgerrand/ex_incident_io.git
cd ex_incident_io
mix deps.get
```

Then you can start running the tests.
```shell
mix test
```

## Contributing

[Bug reports](https://github.com/sgerrand/ex_incident_io/issues) and [pull requests](https://github.com/sgerrand/ex_incident_io/pulls) are welcomed.

## License

This package is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
