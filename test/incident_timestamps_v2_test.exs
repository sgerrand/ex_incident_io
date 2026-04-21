defmodule IncidentIo.IncidentTimestampsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentTimestampsV2

  doctest IncidentIo.IncidentTimestampsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            incident_timestamps: [
              %{
                id: "01FCNDV6P870EA6S7TK1DSYD5H",
                name: "Impact started",
                rank: 1
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

  describe "show/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            incident_timestamp: %{
              id: "01FCNDV6P870EA6S7TK1DSYD5H",
              name: "Impact started",
              rank: 1
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYD5H")
    end

    test "returns expected response" do
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
