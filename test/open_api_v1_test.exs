defmodule IncidentIo.OpenApiV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.OpenApiV1

  doctest IncidentIo.OpenApiV1

  @client IncidentIo.Client.new()

  describe "show/1" do
    test "returns expected HTTP status code" do
      use_cassette "open_api#show" do
        assert {200, _, _} = show(@client)
      end
    end

    test "returns expected response" do
      use_cassette "open_api#show" do
        {200, %{components: components, info: info, openapi: openapi, paths: paths}, _} =
          show(@client)

        assert 235 == Enum.count(components.schemas)

        assert %{
                 description:
                   "This is the API reference for incident.io.\n\nIt documents available API endpoints, provides examples of how to use it, and\ninstructions around things like authentication and error handling.\n\nThe API is hosted at:\n\n- https://api.incident.io/\n\nAnd you will need to create an API key via your [incident.io\ndashboard](https://app.incident.io/settings/api-keys) to make requests.\n\n# Making requests\n\nHere are the key concepts required to make requests to the incident.io API.\n\n## Authentication\n\nFor all requests made to the incident.io API, you'll need an API key.\n\nTo create an API key, head to the incident dashboard and visit [API\nkeys](https://app.incident.io/settings/api-keys). When you create the key,\nyou'll be able to choose what actions it can take for your account: choose\ncarefully, as those roles can only be set when you first create the key. We'll\nonly show you the token once, so make sure you store it somewhere safe.\n\nOnce you have the key, you should make requests to the API that set the\n`Authorization` request header using a \"Bearer\" authentication scheme:\n\n```\nAuthorization: Bearer <YOUR_API_KEY>\n```\n\n## Errors\n\nWe use standard HTTP response codes to indicate the status or failure of API\nrequests.\n\nThe API response body will be JSON, and contain more detailed information on the\nnature of the error.\n\nAn example error when a request is made without an API key:\n\n```json\n{\n  \"type\": \"authentication_error\",\n  \"status\": 401,\n  \"request_id\": \"8e3cc412-b49d-4957-9073-2c19d2c61804\",\n  \"errors\": [\n    {\n      \"code\": \"missing_authorization_material\",\n      \"message\": \"No authorization material provided in request\"\n    }\n  ]\n}\n```\n\nNote that the error:\n\n- Contains the HTTP status (`401`)\n- References the type of error (`authentication_error`)\n- Includes a `request_id` that can be provided to incident.io support to help\n\tdebug questions with your API request\n- Provides a list of individual errors, which go into detail about why the error\n\toccurred\n\nThe most common error will be a 422 Validation Error, which is returned when the\nrequest was rejected due to failing validations.\n\nThese errors look like this:\n\n```json\n{\n  \"type\": \"validation_error\",\n  \"status\": 422,\n  \"request_id\": \"631766c4-4afd-4803-997c-cd700928fa4b\",\n  \"errors\": [\n    {\n      \"code\": \"is_required\",\n      \"message\": \"A severity is required to open an incident\",\n      \"source\": {\n        \"field\": \"severity_id\"\n      }\n    }\n  ]\n}\n```\n\nThis error is caused by not providing a severity identifier, which should be at\nthe `severity_id` field of the request payload. Errors like these can be mapped to\nforms, should you be integrating with the API from a user-interface.\n\n## Compatibility\n\nWe won't make breaking changes to existing API services or endpoints, but will\nexpect integrators to upgrade themselves to the latest API endpoints within 3\nmonths of us deprecating the old service.\n\nWe will make changes that are considered backwards compatible, which include:\n\n- Adding new API endpoints and services\n- Adding new properties to responses from existing API endpoints\n- Reordering properties returned from existing API endpoints\n- Adding optional request parameters to existing API endpoints\n- Altering the format or length of IDs\n- Adding new values to enums\n\nIt is important that clients are robust to these changes, to ensure reliable\nintegrations.\n\nAs an example, if you are generating a client using an openapi-generator, ensure\nthe generated client is configured to support unknown enum values, often\nconfigured via the `enumUnknownDefaultCase` parameter.\n\nWhen breaking changes are unavoidable, we'll create a new service version on a\nseparate path, and run them in parallel.\n\nFor example:\n\n- https://api.incident.io/v1/incidents\n- https://api.incident.io/v2/incidents\n\nFor any questions, email support@incident.io.\n",
                 title: "incident.io",
                 version: "1.0.0"
               } == info

        assert "3.0.3" == openapi
        assert 53 == Enum.count(paths)
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "open_api#show-2" do
        assert {200, _, _} = show(@client, 2)
      end
    end

    test "returns expected response" do
      use_cassette "open_api#show-2" do
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
                 description:
                   "This is the API reference for incident.io.\n\nIt documents available API endpoints, provides examples of how to use it, and\ninstructions around things like authentication and error handling.\n\nThe API is hosted at:\n\n- https://api.incident.io/\n\nAnd you will need to create an API key via your [incident.io\ndashboard](https://app.incident.io/settings/api-keys) to make requests.\n\n# Making requests\n\nHere are the key concepts required to make requests to the incident.io API.\n\n## Authentication\n\nFor all requests made to the incident.io API, you'll need an API key.\n\nTo create an API key, head to the incident dashboard and visit [API\nkeys](https://app.incident.io/settings/api-keys). When you create the key,\nyou'll be able to choose what actions it can take for your account: choose\ncarefully, as those roles can only be set when you first create the key. We'll\nonly show you the token once, so make sure you store it somewhere safe.\n\nOnce you have the key, you should make requests to the API that set the\n`Authorization` request header using a \"Bearer\" authentication scheme:\n\n```\nAuthorization: Bearer <YOUR_API_KEY>\n```\n\n## Errors\n\nWe use standard HTTP response codes to indicate the status or failure of API\nrequests.\n\nThe API response body will be JSON, and contain more detailed information on the\nnature of the error.\n\nAn example error when a request is made without an API key:\n\n```json\n{\n  \"type\": \"authentication_error\",\n  \"status\": 401,\n  \"request_id\": \"8e3cc412-b49d-4957-9073-2c19d2c61804\",\n  \"errors\": [\n    {\n      \"code\": \"missing_authorization_material\",\n      \"message\": \"No authorization material provided in request\"\n    }\n  ]\n}\n```\n\nNote that the error:\n\n- Contains the HTTP status (`401`)\n- References the type of error (`authentication_error`)\n- Includes a `request_id` that can be provided to incident.io support to help\n\tdebug questions with your API request\n- Provides a list of individual errors, which go into detail about why the error\n\toccurred\n\nThe most common error will be a 422 Validation Error, which is returned when the\nrequest was rejected due to failing validations.\n\nThese errors look like this:\n\n```json\n{\n  \"type\": \"validation_error\",\n  \"status\": 422,\n  \"request_id\": \"631766c4-4afd-4803-997c-cd700928fa4b\",\n  \"errors\": [\n    {\n      \"code\": \"is_required\",\n      \"message\": \"A severity is required to open an incident\",\n      \"source\": {\n        \"field\": \"severity_id\"\n      }\n    }\n  ]\n}\n```\n\nThis error is caused by not providing a severity identifier, which should be at\nthe `severity_id` field of the request payload. Errors like these can be mapped to\nforms, should you be integrating with the API from a user-interface.\n\n## Compatibility\n\nWe won't make breaking changes to existing API services or endpoints, but will\nexpect integrators to upgrade themselves to the latest API endpoints within 3\nmonths of us deprecating the old service.\n\nWe will make changes that are considered backwards compatible, which include:\n\n- Adding new API endpoints and services\n- Adding new properties to responses from existing API endpoints\n- Reordering properties returned from existing API endpoints\n- Adding optional request parameters to existing API endpoints\n- Altering the format or length of IDs\n- Adding new values to enums\n\nIt is important that clients are robust to these changes, to ensure reliable\nintegrations.\n\nAs an example, if you are generating a client using an openapi-generator, ensure\nthe generated client is configured to support unknown enum values, often\nconfigured via the `enumUnknownDefaultCase` parameter.\n\nWhen breaking changes are unavoidable, we'll create a new service version on a\nseparate path, and run them in parallel.\n\nFor example:\n\n- https://api.incident.io/v1/incidents\n- https://api.incident.io/v2/incidents\n\nFor any questions, email support@incident.io.\n",
                 title: "incident.io",
                 version: "1.0.0"
               } == info

        assert 157 == Enum.count(paths)
        assert ["application/json", "application/xml", "application/gob"] == produces
        assert "2.0" == swagger
      end
    end
  end
end
