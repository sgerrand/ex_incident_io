defmodule IncidentIo.AlertSourcesV2 do
  @moduledoc """
  List available alert sources for your organisation.

  Alert sources are integrations that can send alerts to incident.io, such as
  PagerDuty, Datadog, or custom HTTP sources.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all alert sources for an organisation.

  ## Example

      IncidentIo.AlertSourcesV2.list(client)

  More information at: https://api-docs.incident.io/tag/Alert-Sources-V2#operation/Alert%20Sources%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get("v2/alert_sources", client)
  end
end
