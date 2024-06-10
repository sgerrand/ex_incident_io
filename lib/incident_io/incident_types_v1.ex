defmodule IncidentIo.IncidentTypesV1 do
  @moduledoc """
  View incident types.

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
end
