defmodule IncidentIo.FollowUpsV2 do
  @moduledoc """
  Manage follow-up actions from incidents.

  Follow-ups are actions identified during an incident that should be completed
  after the incident is resolved. They can be filtered by incident and mode.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all follow-ups for an organisation.

  ## Example

      IncidentIo.FollowUpsV2.list(client)

      IncidentIo.FollowUpsV2.list(client, "some-incident-id")

      IncidentIo.FollowUpsV2.list(client, "some-incident-id", :retrospective)

  More information at: https://api-docs.incident.io/tag/Follow-ups-V2#operation/Follow-ups%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  @spec list(Client.t(), binary) :: IncidentIo.response()
  @spec list(Client.t(), binary, IncidentIo.incident_mode()) :: IncidentIo.response()
  def list(client \\ %Client{}, incident_id \\ nil, incident_mode \\ nil) do
    params =
      [
        incident_id: incident_id,
        incident_mode: incident_mode
      ]
      |> Enum.reject(fn {_, v} -> is_nil(v) end)

    get(
      "v2/follow_ups",
      client,
      params
    )
  end

  @doc """
  Get a single incident follow-up.

  ## Example

      IncidentIo.FollowUpsV2.show(client, "some-follow-up-id")

  More information at: https://api-docs.incident.io/tag/Follow-ups-V2#operation/Follow-ups%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v2/follow_ups/#{id}",
      client
    )
  end

  @doc """
  Create a follow-up for an incident.

  ## Example

      IncidentIo.FollowUpsV2.create(client, %{
        description: "Call the fire brigade",
        incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
        status: "outstanding",
        title: "Cat is stuck in the tree"
      })

  More information at: https://api-docs.incident.io/tag/Follow-ups-V2#operation/Follow-ups%20V2_Create
  """
  @spec create(Client.t(), map()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post("v2/follow_ups", client, body)
  end

  @doc """
  Update an existing follow-up.

  ## Example

      IncidentIo.FollowUpsV2.update(client, "some-follow-up-id", %{status: "completed"})

  More information at: https://api-docs.incident.io/tag/Follow-ups-V2#operation/Follow-ups%20V2_Update
  """
  @spec update(Client.t(), binary, map()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put("v2/follow_ups/#{id}", client, body)
  end
end
