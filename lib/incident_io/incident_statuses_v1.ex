defmodule IncidentIo.IncidentStatusesV1 do
  @moduledoc """
  Manage incident statuses.

  Each incident has a status, picked from one of the statuses configured in your
  organisation's settings.

  Statuses help communicate where an incident is in its lifecycle. You can use
  statuses when filtering incidents in the dashboard, and in workflows and
  announcement rules.
  """

  import IncidentIo
  alias IncidentIo.Client

  @typep create_request_body :: %{
           category: nonempty_binary,
           description: nonempty_binary,
           name: nonempty_binary
         }
  @typep update_request_body :: %{
           description: nonempty_binary,
           name: nonempty_binary
         }

  @doc """
  List all incident statuses for an organisation.

  ## Example

      IncidentIo.IncidentStatusesV1.list(client)

  More information at: https://api-docs.incident.io/tag/Incident-Statuses-V1#operation/Incident-Statuses%20V1_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v1/incident_statuses",
      client
    )
  end

  @doc """
  Create a new incident status.

  incident status body example:
  ```elixir
  %{
    category: "live",
    description: "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
    name: "Closed"
  }
  ```

  ## Example

      IncidentIo.IncidentStatusesV1.create(client, body)

  More information at: https://api-docs.incident.io/tag/Incident-Statuses-V1#operation/Incident-Statuses%20V1_Create
  """
  @spec create(Client.t(), create_request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v1/incident_statuses",
      client,
      body
    )
  end

  @doc """
  Removes an existing incident status.

  ## Example

      IncidentIo.IncidentStatusesV1.destroy(client, "some-incident-status-id")

  More information at: https://api-docs.incident.io/tag/Incident-Statuses-V1#operation/Incident-Statuses%20V1_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete(
      "v1/incident_statuses/#{id}",
      client
    )
  end

  @doc """
  Get a single incident status.

  ## Example

      IncidentIo.IncidentStatusesV1.show(client, "some-incident-status-id")

  More information at: https://api-docs.incident.io/tag/Incident-Statuses-V1#operation/Incident-Statuses%20V1_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v1/incident_statuses/#{id}",
      client
    )
  end

  @doc """
  Update an existing incident status.

  incident status body example:
  ```elixir
  %{
    description: "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
    name: "Closed"
  }
  ```

  ## Example

      IncidentIo.IncidentStatusesV1.update(client, "some-incident-status-id", body)

  More information at: https://api-docs.incident.io/tag/Incident-Statuses-V1#operation/Incident-Statuses%20V1_Update
  """
  @spec update(Client.t(), binary, update_request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put(
      "v1/incident_statuses/#{id}",
      client,
      body
    )
  end
end
