defmodule IncidentIo.IncidentsV1 do
  @moduledoc """
  Create and read incidents.

  Incidents are a core resource, on which many other resources (actions, etc)
  are created.

  Care should be taken around these endpoints, as automation that creates
  duplicate incidents can be distracting, and impact reporting.
  """

  import IncidentIo
  alias IncidentIo.Client

  @typep custom_field_entry :: %{
           custom_field_id: nonempty_binary(),
           values:
             []
             | [
                 %{
                   id: binary,
                   value_catalog_entry_id: binary,
                   value_link: binary,
                   value_numeric: binary,
                   value_option_id: binary,
                   value_text: binary,
                   value_timestamp: binary
                 },
                 ...
               ]
         }
  @typep incident_role_assignment :: %{
           assignee: %{
             email: binary,
             id: binary,
             slack_user_id: binary
           },
           incident_role_id: nonempty_binary()
         }
  @typep mode :: :real | :test
  @typep visibilities :: :public | :private
  @typep create_request_body :: %{
           optional(:custom_field_entries) => [custom_field_entry, ...],
           optional(:incident_type_id) => nonempty_binary(),
           optional(:incident_role_assignments) => [incident_role_assignment, ...],
           optional(:mode) => mode(),
           optional(:name) => nonempty_binary(),
           optional(:severity_id) => nonempty_binary(),
           optional(:slack_team_id) => nonempty_binary(),
           optional(:source_message_channel_id) => nonempty_binary(),
           optional(:source_message_timestamp) => nonempty_binary(),
           optional(:status) => nonempty_binary(),
           optional(:summary) => nonempty_binary(),
           idempotency_key: nonempty_binary(),
           visibility: visibilities()
         }
  @typep request_options() :: %{
           after: binary,
           page_size: pos_integer(),
           status: [binary, ...]
         }

  @doc """
  List all incidents for an organisation.

  ## Example

      IncidentIo.IncidentsV1.list(client)

  More information at: https://api-docs.incident.io/tag/Incidents-V1#operation/Incidents%20V1_List
  """
  @spec list(Client.t(), request_options()) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ %{page_size: nil, after: nil, status: nil}) do
    get(
      "v1/incidents",
      client,
      opts
    )
  end

  @doc """
  Create a new incident.

  incident body example:
  ```elixir
  %{
    category: "live",
    description: "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
    name: "Closed"
  }
  ```

  ## Example

      IncidentIo.IncidentsV1.create(client, body)

  More information at: https://api-docs.incident.io/tag/Incidents-V1#operation/Incidents%20V1_Create
  """
  @spec create(Client.t(), create_request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v1/incidents",
      client,
      body
    )
  end

  @doc """
  Get a single incident.

  ## Example

      IncidentIo.IncidentsV1.show(client, "some-incident-id")

  More information at: https://api-docs.incident.io/tag/Incidents-V1#operation/Incidents%20V1_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v1/incidents/#{id}",
      client
    )
  end
end
