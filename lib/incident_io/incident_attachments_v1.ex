defmodule IncidentIo.IncidentAttachmentsV1 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @typep external_resource_type :: [
           :atlassian_statuspage_incident
           | :datadog_monitor_alert
           | :github_pull_request
           | :gitlab_merge_request
           | :google_calendar_event
           | :jira_issue
           | :opsgenie_alert
           | :pager_duty_incident
           | :scrubbed
           | :sentry_issue
           | :statuspage_incident
           | :zendesk_ticket
         ]

  @doc """
  List all incident attachments for a given external resource or incident. You
  must provide either a specific incident ID or a specific external resource
  type and external ID.

  ## Example

      IncidentIo.IncidentAttachmentsV1.list(client, "some-incident-id")

      IncidentIo.IncidentAttachmentsV1.list(client, nil, "some-external-id", :pager_duty_incident)

  More information at: https://api-docs.incident.io/tag/Follow-ups-V2#operation/Follow-ups%20V2_List
  """
  @spec list(Client.t(), binary) :: IncidentIo.response()
  @spec list(Client.t(), nil, binary, external_resource_type()) :: IncidentIo.response()
  def list(
        client \\ %Client{},
        incident_id \\ nil,
        external_id \\ nil,
        external_resource_type \\ nil
      )

  def list(client, incident_id, external_id, external_resource_type)
      when not is_nil(incident_id) and is_nil(external_id) and is_nil(external_resource_type) do
    get(
      "v1/incident_attachments",
      client,
      incident_id: incident_id
    )
  end

  def list(client, incident_id, external_id, external_resource_type)
      when is_nil(incident_id) and not is_nil(external_id) do
    get(
      "v1/incident_attachments",
      client,
      external_id: external_id,
      external_resource_type: external_resource_type
    )
  end

  def list(_client, _incident_id, _external_id, _external_resource_type),
    do:
      raise(
        "Error: only provide an incident_id *or* external_id and external_resource_type – not both."
      )
end
