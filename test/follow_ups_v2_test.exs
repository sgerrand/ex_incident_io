defmodule IncidentIo.FollowUpsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.FollowUpsV2

  doctest IncidentIo.FollowUpsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "follow_ups_v2#list-1" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "follow_ups_v2#list-1" do
        {200, response, _} = list(@client)

        assert %{
                 follow_ups: [
                   %{
                     assignee: %{
                       email: "lisa@incident.io",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Lisa Karlin Curtis",
                       role: "viewer",
                       slack_user_id: "U02AYNF2XJM"
                     },
                     completed_at: "2021-08-17T13:28:57.801578Z",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Call the fire brigade",
                     external_issue_reference: %{
                       issue_name: "INC-123",
                       issue_permalink:
                         "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                       provider: "asana"
                     },
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     priority: %{
                       description: "A follow-up that requires immediate attention.",
                       id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                       name: "Urgent",
                       rank: 10
                     },
                     status: "outstanding",
                     title: "Cat is stuck in the tree",
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   }
                 ]
               } == response
      end
    end
  end

  describe "list/2" do
    test "returns expected HTTP status code" do
      use_cassette "follow_ups_v2#list-2" do
        assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "follow_ups_v2#list-2" do
        {200, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 follow_ups: [
                   %{
                     assignee: %{
                       email: "lisa@incident.io",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Lisa Karlin Curtis",
                       role: "viewer",
                       slack_user_id: "U02AYNF2XJM"
                     },
                     completed_at: "2021-08-17T13:28:57.801578Z",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Call the fire brigade",
                     external_issue_reference: %{
                       issue_name: "INC-123",
                       issue_permalink:
                         "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                       provider: "asana"
                     },
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     priority: %{
                       description: "A follow-up that requires immediate attention.",
                       id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                       name: "Urgent",
                       rank: 10
                     },
                     status: "outstanding",
                     title: "Cat is stuck in the tree",
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   }
                 ]
               } == response
      end
    end
  end

  describe "list/3" do
    test "returns expected HTTP status code" do
      use_cassette "follow_ups_v2#list-3" do
        assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", :standard)
      end
    end

    test "returns expected response" do
      use_cassette "follow_ups_v2#list-3" do
        {200, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", :standard)

        assert %{
                 follow_ups: [
                   %{
                     assignee: %{
                       email: "lisa@incident.io",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Lisa Karlin Curtis",
                       role: "viewer",
                       slack_user_id: "U02AYNF2XJM"
                     },
                     completed_at: "2021-08-17T13:28:57.801578Z",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Call the fire brigade",
                     external_issue_reference: %{
                       issue_name: "INC-123",
                       issue_permalink:
                         "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                       provider: "asana"
                     },
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     priority: %{
                       description: "A follow-up that requires immediate attention.",
                       id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                       name: "Urgent",
                       rank: 10
                     },
                     status: "outstanding",
                     title: "Cat is stuck in the tree",
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   }
                 ]
               } == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "follow_ups_v2#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "follow_ups_v2#show" do
        {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 follow_up: %{
                   assignee: %{
                     email: "lisa@incident.io",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     name: "Lisa Karlin Curtis",
                     role: "viewer",
                     slack_user_id: "U02AYNF2XJM"
                   },
                   completed_at: "2021-08-17T13:28:57.801578Z",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Call the fire brigade",
                   external_issue_reference: %{
                     issue_name: "INC-123",
                     issue_permalink:
                       "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                     provider: "asana"
                   },
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   priority: %{
                     description: "A follow-up that requires immediate attention.",
                     id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                     name: "Urgent",
                     rank: 10
                   },
                   status: "outstanding",
                   title: "Cat is stuck in the tree",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end
end
