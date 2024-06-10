defmodule IncidentIo.IncidentTimestampsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentTimestampsV2

  doctest IncidentIo.IncidentTimestampsV2

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "incident_timestamps_v2#list" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "incident_timestamps_v2#list" do
        {200, response, _} = list(@client)

        assert %{
                 incident_timestamps: [
                   %{
                     id: "01FCNDV6P870EA6S7TK1DSYD5H",
                     name: "Impact started",
                     rank: 1
                   }
                 ]
               } == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "incident_timestamps_v2#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYD5H")
      end
    end

    test "returns expected response" do
      use_cassette "incident_timestamps_v2#show" do
        {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYD5H")

        assert %{
                 incident_timestamp: %{
                   id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   name: "Impact started",
                   rank: 1
                 }
               } == response
      end
    end
  end
end
