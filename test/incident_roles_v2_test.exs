defmodule IncidentIo.IncidentRolesV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentRolesV2

  doctest IncidentIo.IncidentRolesV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "incident_roles_v2#list" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "incident_roles_v2#list" do
        {200, response, _} = list(@client)

        assert %{
                 incident_roles: [
                   %{
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "The person currently coordinating the incident",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     instructions:
                       "Take point on the incident; Make sure people are clear on responsibilities",
                     name: "Incident Lead",
                     role_type: "lead",
                     shortform: "lead",
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   }
                 ]
               } == response
      end
    end
  end

  describe "create/2" do
    @body %{
      description: "The person currently coordinating the incident",
      instructions: "Take point on the incident; Make sure people are clear on responsibilities",
      name: "Incident Lead",
      shortform: "lead"
    }

    test "returns expected HTTP status code" do
      use_cassette "incident_roles_v2#create" do
        assert {201, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "incident_roles_v2#create" do
        {201, response, _} = create(@client, @body)

        assert %{
                 incident_role: %{
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "The person currently coordinating the incident",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   instructions:
                     "Take point on the incident; Make sure people are clear on responsibilities",
                   name: "Incident Lead",
                   role_type: "lead",
                   shortform: "lead",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end

  describe "destroy/2" do
    test "returns expected HTTP status code" do
      use_cassette "incident_roles_v2#destroy" do
        assert {204, _, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "incident_roles_v2#destroy" do
        {204, response, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert nil == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "incident_roles_v2#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "incident_roles_v2#show" do
        {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 incident_role: %{
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "The person currently coordinating the incident",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   instructions:
                     "Take point on the incident; Make sure people are clear on responsibilities",
                   name: "Incident Lead",
                   role_type: "lead",
                   shortform: "lead",
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
      shortform: "lead"
    }

    test "returns expected HTTP status code" do
      use_cassette "incident_roles_v2#update" do
        assert {200, _, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)
      end
    end

    test "returns expected response" do
      use_cassette "incident_roles_v2#update" do
        {200, response, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)

        assert %{
                 incident_role: %{
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "The person currently coordinating the incident",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   instructions:
                     "Take point on the incident; Make sure people are clear on responsibilities",
                   name: "Incident Lead",
                   role_type: "lead",
                   shortform: "lead",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end
end
