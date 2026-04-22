defmodule IncidentIo.AlertPrioritiesV2 do
  @moduledoc """
  List alert priorities configured for your organisation.

  Alert priorities determine the severity level of alerts and can influence
  how they are routed and handled.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all alert priorities for an organisation.

  ## Example

      IncidentIo.AlertPrioritiesV2.list(client)

  More information at: https://api-docs.incident.io/tag/Alert-Priorities-V2#operation/Alert%20Priorities%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get("v2/alert_priorities", client)
  end
end
