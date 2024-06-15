defmodule IncidentIo.IncidentTypesV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentTypesV1

  doctest IncidentIo.IncidentTypesV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "incident_types_v1#list" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "incident_types_v1#list" do
        {200, response, _} = list(@client)

        assert %{
                 incident_types: [
                   %{
                     create_in_triage: "always",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Customer facing production outages",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     is_default: false,
                     name: "Production Outage",
                     private_incidents_only: false,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   }
                 ]
               } == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "incident_types_v1#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "incident_types_v1#show" do
        {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 incident_type: %{
                   create_in_triage: "always",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Customer facing production outages",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   is_default: false,
                   name: "Production Outage",
                   private_incidents_only: false,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end
end
