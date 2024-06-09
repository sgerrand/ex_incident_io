defmodule IncidentIo.ActionsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.ActionsV2

  doctest IncidentIo.ActionsV2

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/3" do
    test "returns expected HTTP status code" do
      use_cassette "actions_v2#list" do
        assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)
      end
    end

    test "returns expected number of actions" do
      use_cassette "actions_v2#list" do
        {200, %{actions: actions}, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)
        assert Enum.count(actions) == 1
      end
    end

    test "returns expected response" do
      use_cassette "actions_v2#list" do
        {200, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)

        assert %{
                 actions: [
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
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     status: "outstanding",
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   }
                 ]
               } == response
      end
    end
  end

  describe "show/3" do
    test "returns expected HTTP status code" do
      use_cassette "actions_v2#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected attributes for action" do
      use_cassette "actions_v2#show" do
        {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 action: %{
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
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   status: "outstanding",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end
end
