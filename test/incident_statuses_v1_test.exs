defmodule IncidentIo.IncidentStatusesV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentStatusesV1

  doctest IncidentIo.IncidentStatusesV1

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "incident_statuses_v1#list" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "incident_statuses_v1#list" do
        {200, response, _} = list(@client)

        assert %{
                 incident_statuses: [
                   %{
                     category: "triage",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description:
                       "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                     id: "01FCNDV6P870EA6S7TK1DSYD5H",
                     name: "Closed",
                     rank: 4,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   }
                 ]
               } == response
      end
    end
  end

  describe "create/2" do
    @body %{
      category: "live",
      description:
        "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
      name: "Closed"
    }

    test "returns expected HTTP status code" do
      use_cassette "incident_statuses_v1#create" do
        assert {201, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "incident_statuses_v1#create" do
        {201, response, _} = create(@client, @body)

        assert %{
                 incident_status: %{
                   category: "triage",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description:
                     "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                   id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   name: "Closed",
                   rank: 4,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end

  describe "destroy/2" do
    test "returns expected HTTP status code" do
      use_cassette "incident_statuses_v1#delete" do
        assert {204, _, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "incident_statuses_v1#delete" do
        {204, response, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert nil == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "incident_statuses_v1#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYD5H")
      end
    end

    test "returns expected response" do
      use_cassette "incident_statuses_v1#show" do
        {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYD5H")

        assert %{
                 incident_status: %{
                   category: "triage",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description:
                     "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                   id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   name: "Closed",
                   rank: 4,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end

  describe "update/3" do
    @body %{
      description: "The person currently coordinating the incident",
      instructions: "Take point on the incident; Make sure people are clear on responsibilities",
      name: "Incident Lead",
      required: false,
      shortform: "lead"
    }

    test "returns expected HTTP status code" do
      use_cassette "incident_statuses_v1#update" do
        assert {200, _, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYD5H", @body)
      end
    end

    test "returns expected response" do
      use_cassette "incident_statuses_v1#update" do
        {200, response, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYD5H", @body)

        assert %{
                 incident_status: %{
                   category: "triage",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description:
                     "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                   id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   name: "Closed",
                   rank: 4,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end
end
