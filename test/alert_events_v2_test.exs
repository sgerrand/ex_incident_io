defmodule IncidentIo.AlertEventsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.AlertEventsV2

  doctest IncidentIo.AlertEventsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

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
        assert {202, _, _} = create(@client, "01GW2G3V0S59R238FAHPDS1R66", "some-token", @body)
      end
    end

    test "returns expected attributes for action" do
      use_cassette "alert_events_v2#create" do
        {202, response, _} =
          create(@client, "01GW2G3V0S59R238FAHPDS1R66", "some-token", @body)

        assert %{
                 deduplication_key: "unique-key",
                 message: "Event accepted for processing",
                 status: "success"
               } == response
      end
    end
  end
end
