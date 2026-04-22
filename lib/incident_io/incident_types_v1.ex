defmodule IncidentIo.IncidentTypesV1 do
  @moduledoc """
  Manage incident types.

  With incident types enabled, you can tailor your process to the situation
  you're responding to with different custom fields and roles for each incident
  type.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all incident types for an organisation.

  ## Example

      IncidentIo.IncidentTypesV1.list(client)

  More information at: https://api-docs.incident.io/tag/Incident-Types-V1#operation/Incident%20Types%20V1_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v1/incident_types",
      client
    )
  end

  @doc """
  Get a single incident type.

  ## Example

      IncidentIo.IncidentTypesV1.show(client, "some-incident-type-id")

  More information at: https://api-docs.incident.io/tag/Incident-Types-V1#operation/Incident%20Types%20V1_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v1/incident_types/#{id}",
      client
    )
  end

  @doc """
  Create a new incident type.

  ## Example

      IncidentIo.IncidentTypesV1.create(client, %{
        description: "Customer facing production outages",
        name: "Production Outage"
      })

  More information at: https://api-docs.incident.io/tag/Incident-Types-V1#operation/Incident%20Types%20V1_Create
  """
  @spec create(Client.t(), map()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post("v1/incident_types", client, body)
  end

  @doc """
  Update an existing incident type.

  ## Example

      IncidentIo.IncidentTypesV1.update(client, "some-incident-type-id", %{
        name: "Updated Production Outage"
      })

  More information at: https://api-docs.incident.io/tag/Incident-Types-V1#operation/Incident%20Types%20V1_Update
  """
  @spec update(Client.t(), binary, map()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put("v1/incident_types/#{id}", client, body)
  end

  @doc """
  Archives a single incident type.

  ## Example

      IncidentIo.IncidentTypesV1.destroy(client, "some-incident-type-id")

  More information at: https://api-docs.incident.io/tag/Incident-Types-V1#operation/Incident%20Types%20V1_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete("v1/incident_types/#{id}", client)
  end
end
