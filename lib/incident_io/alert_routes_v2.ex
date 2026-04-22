defmodule IncidentIo.AlertRoutesV2 do
  @moduledoc """
  Manage alert routes within incident.io.

  Alert routes determine how incoming alerts are routed to create or update
  incidents based on conditions and configuration.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all alert routes for an organisation.

  ## Example

      IncidentIo.AlertRoutesV2.list(client)

  More information at: https://api-docs.incident.io/tag/Alert-Routes-V2#operation/Alert%20Routes%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  @spec list(Client.t(), keyword) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ []) do
    get("v2/alert_routes", client, opts)
  end

  @doc """
  Create a new alert route.

  ## Example

      IncidentIo.AlertRoutesV2.create(client, %{name: "Production alerts"})

  More information at: https://api-docs.incident.io/tag/Alert-Routes-V2#operation/Alert%20Routes%20V2_Create
  """
  @spec create(Client.t(), map()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post("v2/alert_routes", client, body)
  end

  @doc """
  Get a single alert route.

  ## Example

      IncidentIo.AlertRoutesV2.show(client, "some-alert-route-id")

  More information at: https://api-docs.incident.io/tag/Alert-Routes-V2#operation/Alert%20Routes%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get("v2/alert_routes/#{id}", client)
  end

  @doc """
  Update an existing alert route.

  ## Example

      IncidentIo.AlertRoutesV2.update(client, "some-alert-route-id", %{name: "Updated route"})

  More information at: https://api-docs.incident.io/tag/Alert-Routes-V2#operation/Alert%20Routes%20V2_Update
  """
  @spec update(Client.t(), binary, map()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put("v2/alert_routes/#{id}", client, body)
  end

  @doc """
  Delete an alert route.

  ## Example

      IncidentIo.AlertRoutesV2.destroy(client, "some-alert-route-id")

  More information at: https://api-docs.incident.io/tag/Alert-Routes-V2#operation/Alert%20Routes%20V2_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete("v2/alert_routes/#{id}", client)
  end
end
