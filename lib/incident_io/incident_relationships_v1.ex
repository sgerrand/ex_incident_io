defmodule IncidentIo.IncidentRelationshipsV1 do
  @moduledoc """
  List relationships between incidents.

  Incident relationships track how incidents are linked or related to each
  other, such as parent-child or linked relationships.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all incident relationships for an organisation.

  ## Example

      IncidentIo.IncidentRelationshipsV1.list(client)

  More information at: https://api-docs.incident.io/tag/Incident-Relationships-V1#operation/Incident%20Relationships%20V1_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  @spec list(Client.t(), keyword) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ []) do
    get("v1/incident_relationships", client, opts)
  end
end
