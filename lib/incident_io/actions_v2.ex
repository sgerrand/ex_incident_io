defmodule IncidentIo.ActionsV2 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all actions for an organisation.

  ## Example

      IncidentIo.ActionsV2.list(client, "some-incident-id")

  More information at: https://api-docs.incident.io/tag/Actions-V2#operation/Actions%20V2_List
  """
  @spec list(Client.t(), binary) :: IncidentIo.response()
  @spec list(Client.t(), binary, Client.incident_modes()) :: IncidentIo.response()
  def list(client \\ %Client{}, incident_id, incident_mode \\ :standard) do
    get(
      "v2/actions",
      client,
      %{
        incident_id: incident_id,
        incident_mode: incident_mode
      }
    )
  end

  @doc """
  Get a single incident action.

  ## Example

      IncidentIo.ActionsV2.show(client, "some-action-id")

  More information at: https://api-docs.incident.io/tag/Actions-V2#operation/Actions%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, action_id) do
    get("v2/actions/#{action_id}", client)
  end
end
