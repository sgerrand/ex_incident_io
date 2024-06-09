defmodule IncidentIo.IncidentRolesV1 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all incident roles for an organisation.

  ## Example

      IncidentIo.IncidentRolesV1.list(client, "some-incident-id")

  More information at: https://api-docs.incident.io/tag/Incident-Roles-V1#operation/Incident-Roles%20V1_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v1/incident_roles",
      client
    )
  end
end
