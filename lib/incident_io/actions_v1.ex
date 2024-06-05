defmodule IncidentIo.ActionsV1 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all actions for an organisation.

  ## Example

      IncidentIo.ActionsV1.list(client, "some-incident-id")

  More information at: https://api-docs.incident.io/tag/Actions-V1#operation/Actions%20V1_List
  """
  @spec list(Client.t(), binary) :: IncidentIo.response()
  @spec list(Client.t(), binary, bool) :: IncidentIo.response()
  @spec list(Client.t(), binary, bool, Client.deprecated_incident_modes()) ::
          IncidentIo.response()
  def list(client \\ %Client{}, incident_id, is_follow_up \\ false, incident_mode \\ :test) do
    get(
      "v1/actions",
      client,
      %{
        incident_id: incident_id,
        is_follow_up: is_follow_up,
        incident_mode: incident_mode
      }
    )
  end

  @doc """
  Get a single incident action.

  ## Example

      IncidentIo.ActionsV1.show(client, "some-action-id")

  More information at: https://api-docs.incident.io/tag/Actions-V1#operation/Actions%20V1_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, action_id) do
    get("v1/actions/#{action_id}", client)
  end
end
