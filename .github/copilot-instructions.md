# Copilot Instructions

This is an Elixir HTTP client library for the incident.io API, published as the `incident_io` hex package.

## Request pipeline

`IncidentIo` (the root module) owns the HTTP layer. All resource modules `import IncidentIo` to get `get/3`, `post/3`, `put/3`, and `delete/3` — use `import`, not `alias`. These delegate through `_request/4` → `json_request/5` → `raw_request/5`, which calls `Req.request!()`.

Responses are always `{status_code, decoded_body, %Req.Response{}}` tuples.

## Resource modules

Each API resource lives in `lib/incident_io/<resource>_v<n>.ex` (e.g. `IncidentIo.IncidentsV2`). Resources expose a consistent set of functions — typically `list/2`, `show/2`, `create/2`, `update/3`, `delete/2` — all accepting a `%IncidentIo.Client{}` as the first argument.

```elixir
defmodule IncidentIo.WidgetsV1 do
  import IncidentIo
  alias IncidentIo.Client

  @spec list(Client.t(), keyword) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ []) do
    get("v1/widgets", client, opts)
  end

  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get("v1/widgets/#{id}", client)
  end

  @spec create(Client.t(), map) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post("v1/widgets", client, body)
  end

  @spec delete(Client.t(), binary) :: IncidentIo.response()
  def delete(client \\ %Client{}, id) do
    IncidentIo.delete("v1/widgets/#{id}", client)
  end
end
```

## Types

Use `@typep` for private request/response shape types and keep them close to the functions that use them:

```elixir
@typep create_request_body :: %{
         required_field: binary,
         optional(:optional_field) => binary
       }

@spec create(Client.t(), create_request_body()) :: IncidentIo.response()
def create(client \\ %Client{}, body), do: post("v1/widgets", client, body)
```

## Pagination

For `list` endpoints that return `pagination_meta`, callers use `IncidentIo.Pagination.stream/3`. No special handling is needed inside the resource module itself — just accept an `opts` keyword list and pass it to `get/3`.

## Tests

Tests use `IncidentIo.TestCase` and stub HTTP responses with `Req.Test.stub(:incident_io, ...)`. Each resource function gets a `describe` block with a `setup` that stubs a realistic response, then separate tests for the status code and response body. Mirror `lib/` structure: `test/<resource>_v<n>_test.exs`.

```elixir
defmodule IncidentIo.WidgetsV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.WidgetsV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 200, Jason.encode!(%{widgets: []}))
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected response" do
      {200, response, _} = list(@client)
      assert %{widgets: []} = response
    end
  end

  describe "error responses" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 401, Jason.encode!(%{
          type: "authentication_error",
          status: 401
        }))
      end)

      :ok
    end

    test "returns 401 on authentication failure" do
      assert {401, _, _} = list(@client)
    end

    test "returns error body on authentication failure" do
      {401, response, _} = list(@client)
      assert %{type: "authentication_error", status: 401} = response
    end
  end
end
```
