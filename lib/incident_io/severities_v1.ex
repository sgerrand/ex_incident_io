defmodule IncidentIo.SeveritiesV1 do
  @moduledoc """
  Manage severities.

  Each incident has a severity, picked from one of the severities configured in
  your organisations settings.

  Severities help categorise incidents, and communicate urgency/impact. You can
  use severities when filtering incidents in the dashboard, and in workflows and
  announcement rules.
  """

  import IncidentIo
  alias IncidentIo.Client

  @typep request_body :: %{
           optional(:rank) => pos_integer(),
           description: binary,
           name: binary
         }

  @doc """
  List all severities for an organisation.

  ## Example

      IncidentIo.SeveritiesV1.list(client)

  More information at: https://api-docs.incident.io/tag/Severities-V1#operation/Severities%20V1_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v1/severities",
      client
    )
  end

  @doc """
  Create a new severity.

  Severity body example:
  ```elixir
  %{
    description: "Issues with **low impact**.",
    name: "Minor",
    rank: 1
  }
  ```

  ## Example

      IncidentIo.SeveritiesV1.create(client, body)

  More information at: https://api-docs.incident.io/tag/Severities-V1#operation/Severities%20V1_Create
  """
  @spec create(Client.t(), request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v1/severities",
      client,
      body
    )
  end

  @doc """
  Delete a severity.

  ## Example

      IncidentIo.SeveritiesV1.destroy(client, "some-severity-id")

  More information at: https://api-docs.incident.io/tag/Severities-V1#operation/Severities%20V1_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete(
      "v1/severities/#{id}",
      client
    )
  end

  @doc """
  Get a single severity.

  ## Example

      IncidentIo.SeveritiesV1.show(client, "some-severity-id")

  More information at: https://api-docs.incident.io/tag/Severities-V1#operation/Severities%20V1_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v1/severities/#{id}",
      client
    )
  end

  @doc """
  Update an existing severity.

  Schedule body example:
  ```elixir
  %{
    description: "Issues with **low impact**.",
    name: "Morris Minor",
    rank: 2
  }
  ```

  ## Example

      IncidentIo.SeveritiesV1.update(client, body)

  More information at: https://api-docs.incident.io/tag/Severities-V1#operation/Severities%20V1_Update
  """
  @spec update(Client.t(), binary, request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put(
      "v1/severities/#{id}",
      client,
      body
    )
  end
end
