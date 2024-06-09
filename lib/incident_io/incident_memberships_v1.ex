defmodule IncidentIo.IncidentMembershipsV1 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @typep request_body :: %{
           incident_id: binary,
           user_id: binary
         }

  @doc """
  Makes a user a member of a private incident.

  Incident membership body example:
  ```elixir
  %{
    incident_id: "01ET65M7ZADYFCKD4K1AE2QNMC",
    user_id: "01FCQSP07Z74QMMYPDDGQB9FTG",
  }
  ```

  ## Example

      IncidentIo.IncidentMembershipsV1.create(client, body)

  More information at: https://api-docs.incident.io/tag/Incident-Memberships-V1#operation/Incident-Memberships%20V1_Create
  """
  @spec create(Client.t(), request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v1/incident_memberships",
      client,
      body
    )
  end

  @doc """
  Revoke a user's membership of a private incident.

  Incident membership body example:
  ```elixir
  %{
    incident_id: "01ET65M7ZADYFCKD4K1AE2QNMC",
    user_id: "01FCQSP07Z74QMMYPDDGQB9FTG",
  }
  ```

  ## Example

      IncidentIo.IncidentMembershipsV1.revoke(client, body)

  More information at: https://api-docs.incident.io/tag/Incident-Memberships-V1#operation/Incident-Memberships%20V1_Revoke
  """
  @spec revoke(Client.t(), request_body()) :: IncidentIo.response()
  def revoke(client \\ %Client{}, body) do
    post(
      "v1/incident_memberships/actions/revoke",
      client,
      body
    )
  end
end
