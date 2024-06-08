defmodule IncidentIo.IncidentAttachmentsV1Test do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import IncidentIo.IncidentAttachmentsV1

  doctest IncidentIo.IncidentAttachmentsV1

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/2" do
    test "returns expected HTTP status code" do
      use_cassette "incident_attachments_v2#list-2" do
        assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "incident_attachments_v2#list-2" do
        {200, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 incident_attachments: [
                   %{
                     id: "01FCNDV6P870EA6S7TK1DSYD5H",
                     incident_id: "01FCNDV6P870EA6S7TK1DSYD5H",
                     resource: %{
                       external_id: "123",
                       permalink: "https://my.pagerduty.com/incidents/ABC",
                       resource_type: "pager_duty_incident",
                       title: "The database has gone down"
                     }
                   }
                 ]
               } == response
      end
    end
  end

  describe "list/4" do
    test "returns expected HTTP status code" do
      use_cassette "incident_attachments_v2#list-4" do
        assert {200, _, _} = list(@client, nil, "123", :pager_duty_incident)
      end
    end

    test "returns expected response" do
      use_cassette "incident_attachments_v2#list-4" do
        {200, response, _} = list(@client, nil, "123", :pager_duty_incident)

        assert %{
                 incident_attachments: [
                   %{
                     id: "01FCNDV6P870EA6S7TK1DSYD5H",
                     incident_id: "01FCNDV6P870EA6S7TK1DSYD5H",
                     resource: %{
                       external_id: "123",
                       permalink: "https://my.pagerduty.com/incidents/ABC",
                       resource_type: "pager_duty_incident",
                       title: "The database has gone down"
                     }
                   }
                 ]
               } == response
      end
    end
  end
end
