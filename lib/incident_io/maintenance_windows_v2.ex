defmodule IncidentIo.MaintenanceWindowsV2 do
  @moduledoc """
  Manage maintenance windows for your organisation.

  Maintenance windows suppress alerts during scheduled downtime, preventing
  unnecessary incident creation during planned maintenance periods.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all maintenance windows for an organisation.

  Accepts optional pagination parameters:
  - `:after` - Cursor for pagination
  - `:page_size` - Number of items per page (default: 25, max: 250)

  ## Example

      IncidentIo.MaintenanceWindowsV2.list(client)

      IncidentIo.MaintenanceWindowsV2.list(client, page_size: 50)

  More information at: https://api-docs.incident.io/tag/Maintenance-Windows-V2#operation/Maintenance%20Windows%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  @spec list(Client.t(), keyword) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ []) do
    get("v2/maintenance_windows", client, opts)
  end

  @doc """
  Create a new maintenance window.

  ## Example

      IncidentIo.MaintenanceWindowsV2.create(client, %{
        name: "Weekly maintenance",
        starts_at: "2021-08-17T13:00:00.000000Z",
        ends_at: "2021-08-17T14:00:00.000000Z"
      })

  More information at: https://api-docs.incident.io/tag/Maintenance-Windows-V2#operation/Maintenance%20Windows%20V2_Create
  """
  @spec create(Client.t(), map()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post("v2/maintenance_windows", client, body)
  end

  @doc """
  Get a single maintenance window.

  ## Example

      IncidentIo.MaintenanceWindowsV2.show(client, "some-maintenance-window-id")

  More information at: https://api-docs.incident.io/tag/Maintenance-Windows-V2#operation/Maintenance%20Windows%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get("v2/maintenance_windows/#{id}", client)
  end

  @doc """
  Update an existing maintenance window.

  ## Example

      IncidentIo.MaintenanceWindowsV2.update(client, "some-maintenance-window-id", %{
        name: "Updated maintenance window"
      })

  More information at: https://api-docs.incident.io/tag/Maintenance-Windows-V2#operation/Maintenance%20Windows%20V2_Update
  """
  @spec update(Client.t(), binary, map()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put("v2/maintenance_windows/#{id}", client, body)
  end

  @doc """
  Delete a maintenance window.

  ## Example

      IncidentIo.MaintenanceWindowsV2.destroy(client, "some-maintenance-window-id")

  More information at: https://api-docs.incident.io/tag/Maintenance-Windows-V2#operation/Maintenance%20Windows%20V2_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete("v2/maintenance_windows/#{id}", client)
  end
end
