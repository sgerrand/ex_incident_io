defmodule IncidentIo.OpenApiV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.OpenApiV1

  doctest IncidentIo.OpenApiV1

  @client IncidentIo.Client.new()

  @description ~s"""
  This is the API reference for incident.io.

  It documents available API endpoints, provides examples of how to use it, and
  instructions around things like authentication and error handling.

  The API is hosted at:

  - https://api.incident.io/

  And you will need to create an API key via your [incident.io
  dashboard](https://app.incident.io/settings/api-keys) to make requests.

  # Making requests

  Here are the key concepts required to make requests to the incident.io API.

  ## Authentication

  For all requests made to the incident.io API, you'll need an API key.

  To create an API key, head to the incident dashboard and visit [API
  keys](https://app.incident.io/settings/api-keys). When you create the key,
  you'll be able to choose what actions it can take for your account: choose
  carefully, as those roles can only be set when you first create the key. We'll
  only show you the token once, so make sure you store it somewhere safe.

  Once you have the key, you should make requests to the API that set the
  `Authorization` request header using a "Bearer" authentication scheme:

  ```
  Authorization: Bearer <YOUR_API_KEY>
  ```

  ## Errors

  We use standard HTTP response codes to indicate the status or failure of API
  requests.

  The API response body will be JSON, and contain more detailed information on the
  nature of the error.

  An example error when a request is made without an API key:

  ```json
  {
    "type": "authentication_error",
    "status": 401,
    "request_id": "8e3cc412-b49d-4957-9073-2c19d2c61804",
    "errors": [
      {
        "code": "missing_authorization_material",
        "message": "No authorization material provided in request"
      }
    ]
  }
  ```

  Note that the error:

  - Contains the HTTP status (`401`)
  - References the type of error (`authentication_error`)
  - Includes a `request_id` that can be provided to incident.io support to help
  \tdebug questions with your API request
  - Provides a list of individual errors, which go into detail about why the error
  \toccurred

  The most common error will be a 422 Validation Error, which is returned when the
  request was rejected due to failing validations.

  These errors look like this:

  ```json
  {
    "type": "validation_error",
    "status": 422,
    "request_id": "631766c4-4afd-4803-997c-cd700928fa4b",
    "errors": [
      {
        "code": "is_required",
        "message": "A severity is required to open an incident",
        "source": {
          "field": "severity_id"
        }
      }
    ]
  }
  ```

  This error is caused by not providing a severity identifier, which should be at
  the `severity_id` field of the request payload. Errors like these can be mapped to
  forms, should you be integrating with the API from a user-interface.

  ## Compatibility

  We won't make breaking changes to existing API services or endpoints, but will
  expect integrators to upgrade themselves to the latest API endpoints within 3
  months of us deprecating the old service.

  We will make changes that are considered backwards compatible, which include:

  - Adding new API endpoints and services
  - Adding new properties to responses from existing API endpoints
  - Reordering properties returned from existing API endpoints
  - Adding optional request parameters to existing API endpoints
  - Altering the format or length of IDs
  - Adding new values to enums

  It is important that clients are robust to these changes, to ensure reliable
  integrations.

  As an example, if you are generating a client using an openapi-generator, ensure
  the generated client is configured to support unknown enum values, often
  configured via the `enumUnknownDefaultCase` parameter.

  When breaking changes are unavoidable, we'll create a new service version on a
  separate path, and run them in parallel.

  For example:

  - https://api.incident.io/v1/incidents
  - https://api.incident.io/v2/incidents

  For any questions, email support@incident.io.
  """

  describe "show/1" do
    setup do
      schemas = 1..235 |> Enum.into(%{}, fn i -> {"Schema#{i}", %{type: "object"}} end)
      paths = 1..53 |> Enum.into(%{}, fn i -> {"/path/#{i}", %{get: %{}}} end)

      body =
        Jason.encode!(%{
          components: %{schemas: schemas},
          info: %{
            description: @description,
            title: "incident.io",
            version: "1.0.0"
          },
          openapi: "3.0.3",
          paths: paths
        })

      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 200, body)
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = show(@client)
    end

    test "returns expected response" do
      {200, %{components: components, info: info, openapi: openapi, paths: paths}, _} =
        show(@client)

      assert 235 == Enum.count(components.schemas)

      assert %{
               description: @description,
               title: "incident.io",
               version: "1.0.0"
             } == info

      assert "3.0.3" == openapi
      assert 53 == Enum.count(paths)
    end
  end

  describe "show/2" do
    setup do
      definitions = 1..371 |> Enum.into(%{}, fn i -> {"Definition#{i}", %{type: "object"}} end)
      paths = 1..157 |> Enum.into(%{}, fn i -> {"/v2/path/#{i}", %{get: %{}}} end)

      body =
        Jason.encode!(%{
          consumes: ["application/json", "application/xml", "application/gob"],
          definitions: definitions,
          info: %{
            description: @description,
            title: "incident.io",
            version: "1.0.0"
          },
          paths: paths,
          produces: ["application/json", "application/xml", "application/gob"],
          swagger: "2.0"
        })

      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 200, body)
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = show(@client, 2)
    end

    test "returns expected response" do
      {200,
       %{
         consumes: consumes,
         definitions: definitions,
         info: info,
         paths: paths,
         produces: produces,
         swagger: swagger
       }, _} = show(@client, 2)

      assert ["application/json", "application/xml", "application/gob"] == consumes
      assert 371 == Enum.count(definitions)

      assert %{
               description: @description,
               title: "incident.io",
               version: "1.0.0"
             } == info

      assert 157 == Enum.count(paths)
      assert ["application/json", "application/xml", "application/gob"] == produces
      assert "2.0" == swagger
    end
  end
end
