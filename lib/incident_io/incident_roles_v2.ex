defmodule IncidentIo.IncidentRolesV2 do
  @moduledoc """
  Manage incident roles.

  During an incident, you can assign responders to one of the incident roles
  that are configured in your organisation settings.

  Every organisation will have a special 'lead' role, which signifies the
  incident lead or commander. This role cannot be deleted, but can be renamed in
  the incident.io dashboard.
  """

  import IncidentIo
  alias IncidentIo.Client

  @typep request_body :: %{
           description: nonempty_binary,
           instructions: binary,
           name: nonempty_binary,
           shortform: nonempty_binary
         }

  @doc """
  List all incident roles for an organisation.

  ## Example

      IncidentIo.IncidentRolesV2.list(client, "some-incident-id")

  More information at: https://api-docs.incident.io/tag/Incident-Roles-V2#operation/Incident-Roles%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v2/incident_roles",
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
    shortform: "lead"
  }
  ```

  ## Example

      IncidentIo.IncidentRolesV2.create(client, body)

  More information at: https://api-docs.incident.io/tag/Incident-Roles-V2#operation/Incident-Roles%20V2_Create
  """
  @spec create(Client.t(), request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v2/incident_roles",
      client,
      body
    )
  end

  @doc """
  Removes an existing incident role.

  ## Example

      IncidentIo.IncidentRolesV2.destroy(client, "some-incident-role-id")

  More information at: https://api-docs.incident.io/tag/Incident-Roles-V2#operation/Incident-Roles%20V2_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete(
      "v2/incident_roles/#{id}",
      client
    )
  end

  @doc """
  Get a single incident role.

  ## Example

      IncidentIo.IncidentRolesV2.show(client, "some-incident-role-id")

  More information at: https://api-docs.incident.io/tag/Incident-Roles-V2#operation/Incident-Roles%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v2/incident_roles/#{id}",
      client
    )
  end

  @doc """
  Update an existing incident role.

  Incident role body example:
  ```elixir
  %{
    description: "The person currently coordinating the incident",
    instructions: "Take point on the incident; Make sure people are clear on responsibilities",
    name: "Incident Lead",
    shortform: "lead"
  }
  ```

  ## Example

      IncidentIo.IncidentRolesV2.update(client, "some-incident-id", body)

  More information at: https://api-docs.incident.io/tag/Incident-Roles-V2#operation/Incident-Roles%20V2_Update
  """
  @spec update(Client.t(), binary, request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put(
      "v2/incident_roles/#{id}",
      client,
      body
    )
  end
end
