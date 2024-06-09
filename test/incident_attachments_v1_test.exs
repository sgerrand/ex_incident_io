defmodule IncidentIo.IncidentAttachmentsV1Test do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import IncidentIo.IncidentAttachmentsV1

  doctest IncidentIo.IncidentAttachmentsV1

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/2" do
    test "returns expected HTTP status code" do
      use_cassette "incident_attachments_v1#list-2" do
        assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "incident_attachments_v1#list-2" do
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
      use_cassette "incident_attachments_v1#list-4" do
        assert {200, _, _} = list(@client, nil, "123", :pager_duty_incident)
      end
    end

    test "returns expected response" do
      use_cassette "incident_attachments_v1#list-4" do
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

  describe "create/2" do
    @body %{
      incident_id: "01FDAG4SAP5TYPT98WGR2N7W91",
      resource: %{
        external_id: "123",
        resource_type: "pager_duty_incident"
      }
    }

    test "returns expected HTTP status code" do
      use_cassette "incident_attachments_v1#create" do
        assert {201, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "incident_attachments_v1#create" do
        {201, response, _} = create(@client, @body)

        assert %{
                 incident_attachment: %{
                   id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   incident_id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   resource: %{
                     external_id: "123",
                     permalink: "https://my.pagerduty.com/incidents/ABC",
                     resource_type: "pager_duty_incident",
                     title: "The database has gone down"
                   }
                 }
               } == response
      end
    end
  end

  describe "delete/2" do
    test "returns expected HTTP status code" do
      use_cassette "incident_attachments_v1#destroy" do
        assert {204, _, _} = destroy(@client, "01FDAG4SAP5TYPT98WGR2N7W91")
      end
    end

    test "returns expected response" do
      use_cassette "incident_attachments_v1#destroy" do
        {204, response, _} = destroy(@client, "01FDAG4SAP5TYPT98WGR2N7W91")

        assert nil == response
      end
    end
  end
end
