defmodule IncidentIo.ActionsV2 do
  @moduledoc """
  Manage actions attached to incidents.

  Actions are tasks that responders create during an incident to track work
  that needs to be done. This module covers the v2 Actions API, supporting
  full CRUD operations.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all actions for an organisation.

  ## Example

      IncidentIo.ActionsV2.list(client, "some-incident-id")

  More information at: https://api-docs.incident.io/tag/Actions-V2#operation/Actions%20V2_List
  """
  @spec list(Client.t(), binary) :: IncidentIo.response()
  @spec list(Client.t(), binary, IncidentIo.incident_mode()) :: IncidentIo.response()
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

  @doc """
  Create an action for an incident.

  ## Example

      IncidentIo.ActionsV2.create(client, %{
        assignee_id: "01FCNDV6P870EA6S7TK1DSYDG0",
        description: "Call the fire brigade",
        incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
        status: "outstanding"
      })

  More information at: https://api-docs.incident.io/tag/Actions-V2#operation/Actions%20V2_Create
  """
  @spec create(Client.t(), map()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post("v2/actions", client, body)
  end

  @doc """
  Update an existing action.

  ## Example

      IncidentIo.ActionsV2.update(client, "some-action-id", %{status: "completed"})

  More information at: https://api-docs.incident.io/tag/Actions-V2#operation/Actions%20V2_Update
  """
  @spec update(Client.t(), binary, map()) :: IncidentIo.response()
  def update(client \\ %Client{}, action_id, body) do
    patch("v2/actions/#{action_id}", client, body)
  end
end
