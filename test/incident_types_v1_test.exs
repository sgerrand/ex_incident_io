defmodule IncidentIo.IncidentTypesV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentTypesV1

  doctest IncidentIo.IncidentTypesV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
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
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected response" do
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

  describe "show/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
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
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns expected response" do
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
