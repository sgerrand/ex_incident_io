defmodule IncidentIo.IncidentTimestampsV2 do
  @moduledoc """
  View incident timestamps.

  Each incident has a number of timestamps: some being defaults that we set on
  each incident for you, and others being configured for your organisation within
  settings.

  Timestamps help to communicate when a given action was taken for a specific
  incident, for example when it was reported, closed or fixed.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all incident timestamps for an organisation.

  ## Example

      IncidentIo.IncidentTimestampsV2.list(client)

  More information at: https://api-docs.incident.io/tag/Incident-Timestamps-V2#operation/Incident-Timestamps%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v2/incident_timestamps",
      client
    )
  end

  @doc """
  Get a single incident timestamp.

  ## Example

      IncidentIo.IncidentTimestampsV2.show(client, "some-incident-timestamp-id")

  More information at: https://api-docs.incident.io/tag/Incident-Timestamps-V2#operation/Incident-Timestamps%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v2/incident_timestamps/#{id}",
      client
    )
  end
end
