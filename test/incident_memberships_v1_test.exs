defmodule IncidentIo.IncidentMembershipsV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentMembershipsV1

  doctest IncidentIo.IncidentMembershipsV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "create/2" do
    @body %{
      incident_id: "01ET65M7ZADYFCKD4K1AE2QNMC",
      user_id: "01FCQSP07Z74QMMYPDDGQB9FTG"
    }

    test "returns expected HTTP status code" do
      use_cassette "incident_memberships_v1#create" do
        assert {201, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "incident_memberships_v1#create" do
        {201, response, _} = create(@client, @body)

        assert %{
                 incident_id: "01ET65M7ZADYFCKD4K1AE2QNMC",
                 user_id: "01FCQSP07Z74QMMYPDDGQB9FTG"
               } == response
      end
    end
  end

  describe "revoke/2" do
    @body %{
      incident_id: "01ET65M7ZADYFCKD4K1AE2QNMC",
      user_id: "01FCQSP07Z74QMMYPDDGQB9FTG"
    }

    test "returns expected HTTP status code" do
      use_cassette "incident_memberships_v1#revoke" do
        assert {204, _, _} = revoke(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "incident_memberships_v1#revoke" do
        {204, response, _} = revoke(@client, @body)

        assert nil == response
      end
    end
  end
end
