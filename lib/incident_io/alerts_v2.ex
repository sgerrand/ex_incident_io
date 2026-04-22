defmodule IncidentIo.AlertsV2 do
  @moduledoc """
  Manage alerts within incident.io.

  Alerts are notifications from monitoring systems that can trigger incidents.
  This is distinct from `IncidentIo.AlertEventsV2` which handles inbound
  webhook alert events from HTTP sources.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all alerts for an organisation.

  Accepts optional pagination parameters:
  - `:after` - Cursor for pagination
  - `:page_size` - Number of items per page (default: 25, max: 250)

  ## Example

      IncidentIo.AlertsV2.list(client)

      IncidentIo.AlertsV2.list(client, page_size: 50)

  More information at: https://api-docs.incident.io/tag/Alerts-V2#operation/Alerts%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  @spec list(Client.t(), keyword) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ []) do
    get("v2/alerts", client, opts)
  end

  @doc """
  Create a new alert.

  ## Example

      IncidentIo.AlertsV2.create(client, %{
        title: "High error rate on api.example.com",
        status: "firing"
      })

  More information at: https://api-docs.incident.io/tag/Alerts-V2#operation/Alerts%20V2_Create
  """
  @spec create(Client.t(), map()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post("v2/alerts", client, body)
  end

  @doc """
  Get a single alert.

  ## Example

      IncidentIo.AlertsV2.show(client, "some-alert-id")

  More information at: https://api-docs.incident.io/tag/Alerts-V2#operation/Alerts%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get("v2/alerts/#{id}", client)
  end
end
