defmodule IncidentIo.IncidentsV2 do
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
  @typep incident_timestamp_value :: %{
           optional(:value) => binary,
           incident_timestamp_id: nonempty_binary()
         }
  @typep mode :: IncidentIo.incident_mode()
  @typep operators_date :: :gte | :lte | :date_range
  @typep operators_group :: :one_of | :not_in
  @typep operators_mode :: :one_of
  @typep operators_severity :: :one_of | :not_in | :gte | :lte
  @typep operators_role :: :one_of | :is_blank
  @typep visibilities :: :public | :private
  @typep create_request_body :: %{
           optional(:custom_field_entries) => [custom_field_entry, ...],
           optional(:id) => nonempty_binary(),
           optional(:incident_role_assignments) => [incident_role_assignment, ...],
           optional(:incident_status_id) => nonempty_binary(),
           optional(:incident_timestamp_values) => [incident_timestamp_value(), ...],
           optional(:incident_type_id) => nonempty_binary(),
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
  @typep update_request_body :: %{
           incident: %{
             optional(:call_url) => binary,
             optional(:custom_field_entries) => [custom_field_entry, ...],
             optional(:incident_role_assignments) => [incident_role_assignment, ...],
             optional(:incident_status_id) => nonempty_binary(),
             optional(:incident_timestamp_values) => [incident_timestamp_value(), ...],
             optional(:name) => nonempty_binary(),
             optional(:severity_id) => nonempty_binary(),
             optional(:summary) => nonempty_binary()
           },
           notify_incident_channel: bool
         }
  @typep request_options() :: %{
           after: binary,
           page_size: pos_integer(),
           status: %{
             operators_group() => nonempty_binary()
           },
           status_category: %{
             operators_group() => [nonempty_binary(), ...]
           },
           created_at: %{
             operators_date() => [nonempty_binary(), ...]
           },
           severity: %{
             operators_severity() => [nonempty_binary(), ...]
           },
           incident_type: %{
             operators_group() => [nonempty_binary(), ...]
           },
           incident_role: %{
             nonempty_binary() => %{
               operators_role() => [nonempty_binary(), ...]
             }
           },
           custom_field: %{
             nonempty_binary() => %{
               operators_group() => [nonempty_binary(), ...]
             }
           },
           mode: %{
             operators_mode() => [nonempty_binary(), ...]
           }
         }

  @doc """
  List all incidents for an organisation.

  ## Example

      IncidentIo.IncidentsV2.list(client)

  More information at: https://api-docs.incident.io/tag/Incidents-V2#operation/Incidents%20V2_List
  """
  @spec list(Client.t(), request_options()) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ []) do
    get(
      "v2/incidents",
      client,
      opts
    )
  end

  @doc """
  Create a new incident.

  Incident body example:
  ```elixir
  %{
    custom_field_entries: [
      %{
        custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
        values: [
          %{
            id: "01FCNDV6P870EA6S7TK1DSYDG0",
            value_catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
            value_link: "https://google.com/",
            value_numeric: "123.456",
            value_option_id: "01FCNDV6P870EA6S7TK1DSYDG0",
            value_text: "This is my text field, I hope you like it",
            value_timestamp: ""
          }
        ]
      }
    ],
    id: "01FDAG4SAP5TYPT98WGR2N7W91",
    idempotency_key: "alert-uuid",
    incident_role_assignments: [
      %{
        assignee: %{
          email: "bob@example.com",
          id: "01G0J1EXE7AXZ2C93K61WBPYEH",
          slack_user_id: "USER123"
        },
        incident_role_id: "01FH5TZRWMNAFB0DZ23FD1TV96"
      }
    ],
    incident_status_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
    incident_timestamp_values: [
      %{
        incident_timestamp_id: "01FCNDV6P870EA6S7TK1DSYD5H",
        value: "2021-08-17T13:28:57.801578Z"
      }
    ],
    incident_type_id: "01FH5TZRWMNAFB0DZ23FD1TV96",
    mode: "standard",
    name: "Our database is sad",
    retrospective_incident_options: %{
      postmortem_document_url: "https://docs.google.com/my_doc_id",
      slack_channel_id: "abc123"
    },
    severity_id: "01FH5TZRWMNAFB0DZ23FD1TV96",
    slack_channel_name_override: "inc-123-database-down",
    slack_team_id: "T02A1FSLE8J",
    summary: "Our database is really really sad, and we don't know why yet.",
    visibility: "public"
  }
  ```

  ## Example

      IncidentIo.IncidentsV2.create(client, body)

  More information at: https://api-docs.incident.io/tag/Incidents-V2#operation/Incidents%20V2_Create
  """
  @spec create(Client.t(), create_request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v2/incidents",
      client,
      body
    )
  end

  @doc """
  Get a single incident.

  ## Example

      IncidentIo.IncidentsV2.show(client, "some-incident-id")

  More information at: https://api-docs.incident.io/tag/Incidents-V2#operation/Incidents%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v2/incidents/#{id}",
      client
    )
  end

  @doc """
  Update an existing incident.

  Incident body example:
  ```elixir
  %{
    incident: %{
      call_url: "https://zoom.us/foo",
      custom_field_entries: [
        %{
          custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
          values: [
            %{
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              value_catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              value_link: "https://google.com/",
              value_numeric: "123.456",
              value_option_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              value_text: "This is my text field, I hope you like it",
              value_timestamp: ""
            }
          ]
        }
      ],
      incident_role_assignments: [
        %{
          assignee: %{
            email: "bob@example.com",
            id: "01G0J1EXE7AXZ2C93K61WBPYEH",
            slack_user_id: "USER123"
          },
          incident_role_id: "01FH5TZRWMNAFB0DZ23FD1TV96"
        }
      ],
      incident_status_id: "01FH5TZRWMNAFB0DZ23FD1TV96",
      incident_timestamp_values: [
        %{
          incident_timestamp_id: "01FCNDV6P870EA6S7TK1DSYD5H",
          value: "2021-08-17T13:28:57.801578Z"
        }
      ],
      name: "Our database is sad",
      severity_id: "01FH5TZRWMNAFB0DZ23FD1TV96",
      summary: "Our database is really really sad, and we don't know why yet."
    },
    notify_incident_channel: true
  }
  ```

  ## Example

      IncidentIo.IncidentsV2.update(client, "some-incident-id", body)

  More information at: https://api-docs.incident.io/tag/Incidents-V2#operation/Incidents%20V2_Update
  """
  @spec update(Client.t(), binary, update_request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    post(
      "v2/incidents/#{id}/actions/edit",
      client,
      body
    )
  end
end
