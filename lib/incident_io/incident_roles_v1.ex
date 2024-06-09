defmodule IncidentIo.IncidentRolesV1 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @typep request_body :: %{
           description: nonempty_binary,
           instructions: binary,
           name: nonempty_binary,
           required: bool,
           shortform: nonempty_binary
         }

  @doc """
  List all incident roles for an organisation.

  ## Example

      IncidentIo.IncidentRolesV1.list(client, "some-incident-id")

  More information at: https://api-docs.incident.io/tag/Incident-Roles-V1#operation/Incident-Roles%20V1_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v1/incident_roles",
      client
    )
  end

  @doc """
  Create a new incident role.

  Incident role body example:
  ```elixir
  %{
    description: "The person currently coordinating the incident",
    instructions: "Take point on the incident; Make sure people are clear on responsibilities",
    name: "Incident Lead",
    required: false,
    shortform: "lead"
  }
  ```

  ## Example

      IncidentIo.IncidentRolesV1.create(client, "some-incident-id")

  More information at: https://api-docs.incident.io/tag/Incident-Roles-V1#operation/Incident-Roles%20V1_Create
  """
  @spec create(Client.t(), request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v1/incident_roles",
      client,
      body
    )
  end

  @doc """
  Removes an existing incident role.

  ## Example

      IncidentIo.IncidentRolesV1.destroy(client, "some-incident-role-id")

  More information at: https://api-docs.incident.io/tag/Incident-Roles-V1#operation/Incident-Roles%20V1_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete(
      "v1/incident_roles/#{id}",
      client
    )
  end

  @doc """
  Get a single incident role.

  ## Example

      IncidentIo.IncidentRolesV1.show(client, "some-incident-role-id")

  More information at: https://api-docs.incident.io/tag/Incident-Roles-V1#operation/Incident-Roles%20V1_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v1/incident_roles/#{id}",
      client
    )
  end
end
