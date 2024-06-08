defmodule IncidentIo.FollowUpsV2 do
  @moduledoc false

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
  @spec list(Client.t(), binary, IncidentIo.incident_modes()) :: IncidentIo.response()
  def list(client \\ %Client{}, incident_id \\ nil, incident_mode \\ nil) do
    params =
      [
        incident_id: incident_id,
        incident_mode: incident_mode
      ]
      |> Enum.drop_while(fn {_key, val} -> is_nil(val) end)

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
end
