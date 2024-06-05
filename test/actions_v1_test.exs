defmodule IncidentIo.ActionsV1Test do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import IncidentIo.ActionsV1

  doctest IncidentIo.ActionsV1

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/3" do
    test "returns expected HTTP status code" do
      use_cassette "actions_v1#list" do
        assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)
      end
    end

    test "returns expected number of actions" do
      use_cassette "actions_v1#list" do
        {200, %{actions: actions}, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)
        assert Enum.count(actions) == 1
      end
    end

    test "returns expected attributes for action" do
      use_cassette "actions_v1#list" do
        {200, %{actions: [action]}, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)

        %{
          assignee: _assignee,
          completed_at: completed_at,
          created_at: created_at,
          description: description,
          external_issue_reference: _external_issue_reference,
          follow_up: follow_up,
          id: id,
          incident_id: incident_id,
          status: status,
          updated_at: updated_at
        } = action

        assert completed_at == "2021-08-17T13:28:57.801578Z"
        assert created_at == "2021-08-17T13:28:57.801578Z"
        assert description == "Call the fire brigade"
        assert follow_up == true
        assert id == "01FCNDV6P870EA6S7TK1DSYDG0"
        assert incident_id == "01FCNDV6P870EA6S7TK1DSYDG0"
        assert status == "outstanding"
        assert updated_at == "2021-08-17T13:28:57.801578Z"
      end
    end

    test "returns expected attributes for action assignee" do
      use_cassette "actions_v1#list" do
        {200, %{actions: [%{assignee: assignee}]}, _} =
          list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        %{
          email: email,
          id: id,
          name: name,
          role: role,
          slack_user_id: slack_user_id
        } = assignee

        assert email == "lisa@incident.io"
        assert id == "01FCNDV6P870EA6S7TK1DSYDG0"
        assert name == "Lisa Karlin Curtis"
        assert role == "viewer"
        assert slack_user_id == "U02AYNF2XJM"
      end
    end
  end

  describe "show/3" do
    test "returns expected HTTP status code" do
      use_cassette "actions_v1#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected attributes for action" do
      use_cassette "actions_v1#show" do
        {200, %{action: action}, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        %{
          assignee: _assignee,
          completed_at: completed_at,
          created_at: created_at,
          description: description,
          external_issue_reference: _external_issue_reference,
          follow_up: follow_up,
          id: id,
          incident_id: incident_id,
          status: status,
          updated_at: updated_at
        } = action

        assert completed_at == "2021-08-17T13:28:57.801578Z"
        assert created_at == "2021-08-17T13:28:57.801578Z"
        assert description == "Call the fire brigade"
        assert follow_up == true
        assert id == "01FCNDV6P870EA6S7TK1DSYDG0"
        assert incident_id == "01FCNDV6P870EA6S7TK1DSYDG0"
        assert status == "outstanding"
        assert updated_at == "2021-08-17T13:28:57.801578Z"
      end
    end
  end
end
