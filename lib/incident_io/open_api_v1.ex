defmodule IncidentIo.OpenApiV1 do
  @moduledoc """
  Test if your API key is valid, and which roles it has.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  Get the OpenAPI specification for the Incident.io API.

  ## Example

      IncidentIo.OpenApiV1.show(client)

      IncidentIo.OpenApiV1.show(client, 2)

  More information at: https://api-docs.incident.io/tag/Utilities-V1#operation/Utilities%20V1_OpenAPIV3
  """
  @spec show(Client.t(), pos_integer) :: IncidentIo.response()
  def show(_client \\ %Client{}, open_api_version \\ 3) do
    filename =
      case open_api_version do
        3 -> "openapiV3.json"
        _ -> "openapi.json"
      end

    get(
      "v1/#{filename}",
      %Client{}
    )
  end
end
