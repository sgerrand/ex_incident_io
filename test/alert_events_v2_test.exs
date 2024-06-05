defmodule IncidentIo.AlertEventsV2Test do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import IncidentIo.AlertEventsV2

  doctest IncidentIo.AlertEventsV2

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "create/4" do
    @body %{
      deduplication_key: "4293868629",
      description:
        "We've detected a number of timeouts on hello.world.com, the service may be down. To fix...",
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

    test "returns expected HTTP status code" do
      use_cassette "alert_events_v2#create" do
        assert {202, _, _} = create(@client, "some-alert-source-config-id", "some-token", @body)
      end
    end

    test "returns expected attributes for action" do
      use_cassette "alert_events_v2#create" do
        {202, %{deduplication_key: deduplication_key, message: message, status: status}, _} =
          create(@client, "some-alert-source-config-id", "some-token", @body)

        assert deduplication_key == "unique-key"
        assert message == "Event accepted for processing"
        assert status == "success"
      end
    end
  end
end
