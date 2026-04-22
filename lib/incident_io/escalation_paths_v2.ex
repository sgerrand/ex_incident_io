defmodule IncidentIo.EscalationPathsV2 do
  @moduledoc """
  Manage escalation paths for your organisation.

  Escalation paths define how alerts and incidents are escalated through your
  team, specifying who gets notified and when if an incident goes unacknowledged.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all escalation paths for an organisation.

  Accepts optional pagination parameters:
  - `:after` - Cursor for pagination
  - `:page_size` - Number of items per page (default: 25, max: 250)

  ## Example

      IncidentIo.EscalationPathsV2.list(client)

      IncidentIo.EscalationPathsV2.list(client, page_size: 50)

  More information at: https://api-docs.incident.io/tag/Escalation-Paths-V2#operation/Escalation%20Paths%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  @spec list(Client.t(), keyword) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ []) do
    get("v2/escalation_paths", client, opts)
  end

  @doc """
  Create a new escalation path.

  ## Example

      IncidentIo.EscalationPathsV2.create(client, %{name: "Default Escalation Path"})

  More information at: https://api-docs.incident.io/tag/Escalation-Paths-V2#operation/Escalation%20Paths%20V2_Create
  """
  @spec create(Client.t(), map()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post("v2/escalation_paths", client, body)
  end

  @doc """
  Get a single escalation path.

  ## Example

      IncidentIo.EscalationPathsV2.show(client, "some-escalation-path-id")

  More information at: https://api-docs.incident.io/tag/Escalation-Paths-V2#operation/Escalation%20Paths%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get("v2/escalation_paths/#{id}", client)
  end

  @doc """
  Update an existing escalation path.

  ## Example

      IncidentIo.EscalationPathsV2.update(client, "some-escalation-path-id", %{
        name: "Updated Escalation Path"
      })

  More information at: https://api-docs.incident.io/tag/Escalation-Paths-V2#operation/Escalation%20Paths%20V2_Update
  """
  @spec update(Client.t(), binary, map()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put("v2/escalation_paths/#{id}", client, body)
  end

  @doc """
  Delete an escalation path.

  ## Example

      IncidentIo.EscalationPathsV2.destroy(client, "some-escalation-path-id")

  More information at: https://api-docs.incident.io/tag/Escalation-Paths-V2#operation/Escalation%20Paths%20V2_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete("v2/escalation_paths/#{id}", client)
  end
end
