defmodule IncidentIo.ApiKeysV1 do
  @moduledoc """
  Manage API keys for your organisation.

  API keys are used to authenticate requests to the incident.io API. This
  module supports listing, creating, updating, and rotating API keys.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all API keys for an organisation.

  ## Example

      IncidentIo.ApiKeysV1.list(client)

  More information at: https://api-docs.incident.io/tag/API-Keys-V1#operation/API%20Keys%20V1_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get("v1/api_keys", client)
  end

  @doc """
  Create a new API key.

  ## Example

      IncidentIo.ApiKeysV1.create(client, %{name: "My API Key"})

  More information at: https://api-docs.incident.io/tag/API-Keys-V1#operation/API%20Keys%20V1_Create
  """
  @spec create(Client.t(), map()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post("v1/api_keys", client, body)
  end

  @doc """
  Get a single API key.

  ## Example

      IncidentIo.ApiKeysV1.show(client, "some-api-key-id")

  More information at: https://api-docs.incident.io/tag/API-Keys-V1#operation/API%20Keys%20V1_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get("v1/api_keys/#{id}", client)
  end

  @doc """
  Update an existing API key.

  ## Example

      IncidentIo.ApiKeysV1.update(client, "some-api-key-id", %{name: "Updated Key Name"})

  More information at: https://api-docs.incident.io/tag/API-Keys-V1#operation/API%20Keys%20V1_Update
  """
  @spec update(Client.t(), binary, map()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put("v1/api_keys/#{id}", client, body)
  end

  @doc """
  Delete an API key.

  ## Example

      IncidentIo.ApiKeysV1.destroy(client, "some-api-key-id")

  More information at: https://api-docs.incident.io/tag/API-Keys-V1#operation/API%20Keys%20V1_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete("v1/api_keys/#{id}", client)
  end

  @doc """
  Rotate an API key, generating a new token.

  ## Example

      IncidentIo.ApiKeysV1.rotate(client, "some-api-key-id")

  More information at: https://api-docs.incident.io/tag/API-Keys-V1#operation/API%20Keys%20V1_Rotate
  """
  @spec rotate(Client.t(), binary) :: IncidentIo.response()
  def rotate(client \\ %Client{}, id) do
    post("v1/api_keys/#{id}/actions/rotate", client, %{})
  end
end
