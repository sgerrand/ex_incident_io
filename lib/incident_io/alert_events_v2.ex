defmodule IncidentIo.AlertEventsV2 do
  @moduledoc """
  Send alert events to incident.io via HTTP alert sources.

  Alert events allow external systems to push alerts into incident.io, which
  can then trigger incidents automatically based on your alert routing rules.
  """

  import IncidentIo
  alias IncidentIo.Client

  @type body :: %{
          deduplication_key: binary,
          description: binary,
          metadata: %{
            service: binary,
            team: list
          },
          source_url: binary,
          status: binary,
          title: binary
        }

  @doc """
  Create an alert event using an HTTP source.

  Alert event body example:
  ```elixir
  %{
    deduplication_key: "4293868629",
    description: "We've detected a number of timeouts on hello.world.com, the service may be down. To fix...",
    metadata: %{
      service: "hello.world.com",
      team: [
        "my-team"
      ]
    },
    source_url: "https://www.my-alerting-platform.com/alerts/my-alert-123",
    status: "firing",
    title: "*errors.withMessage: PG::Error failed to connect"
  }
  ```

  ## Example

      IncidentIo.AlertEventsV2.create(client, "some-alert-source-config-id", "some-token", body)

  More information at: https://api-docs.incident.io/tag/Alert-Events-V2#operation/Alert-Eventss%20V2_Create
  """
  @spec create(Client.t(), binary, binary, body()) :: IncidentIo.response()
  def create(client \\ %Client{}, alert_source_config_id, token, body) do
    path = add_params_to_url("v2/alert_events/http/#{alert_source_config_id}", token: token)

    post(
      path,
      client,
      body
    )
  end
end
