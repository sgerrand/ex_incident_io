defmodule IncidentIo.SeveritiesV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.SeveritiesV1

  doctest IncidentIo.SeveritiesV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "severities#list" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "severities#list" do
        {200, response, _} = list(@client)

        assert %{
                 severities: [
                   %{
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Issues with **low impact**.",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     name: "Minor",
                     rank: 1,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   }
                 ]
               } == response
      end
    end
  end

  describe "create/2" do
    @body %{
      description: "Issues with **low impact**.",
      name: "Minor",
      rank: 1
    }

    test "returns expected HTTP status code" do
      use_cassette "severities#create" do
        assert {201, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "severities#create" do
        {201, response, _} = create(@client, @body)

        assert %{
                 severity: %{
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Issues with **low impact**.",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Minor",
                   rank: 1,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end

  describe "destroy/2" do
    test "returns expected HTTP status code" do
      use_cassette "severities#delete" do
        assert {202, _, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "severities#delete" do
        {202, response, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert nil == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "severities#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "severities#show" do
        {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 severity: %{
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Issues with **low impact**.",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Minor",
                   rank: 1,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end

  describe "update/3" do
    @body %{
      description: "Issues with **low impact**.",
      name: "Minor",
      rank: 1
    }

    test "returns expected HTTP status code" do
      use_cassette "severities#update" do
        assert {200, _, _} = update(@client, "01G0J1EXE7AXZ2C93K61WBPYEH", @body)
      end
    end

    test "returns expected response" do
      use_cassette "severities#update" do
        {200, response, _} = update(@client, "01G0J1EXE7AXZ2C93K61WBPYEH", @body)

        assert %{
                 severity: %{
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Issues with **low impact**.",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Minor",
                   rank: 1,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end
end
