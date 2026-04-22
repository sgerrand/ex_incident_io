defmodule IncidentIo.AlertPrioritiesV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.AlertPrioritiesV2

  doctest IncidentIo.AlertPrioritiesV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            alert_priorities: [
              %{
                description: "A high-priority alert requiring immediate attention.",
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                name: "High",
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

    test "returns expected number of alert priorities" do
      {200, %{alert_priorities: alert_priorities}, _} = list(@client)
      assert Enum.count(alert_priorities) == 1
    end

    test "returns expected response" do
      {200, response, _} = list(@client)

      assert %{
               alert_priorities: [
                 %{
                   description: "A high-priority alert requiring immediate attention.",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "High",
                   rank: 1
                 }
               ]
             } == response
    end
  end

  describe "error responses" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          401,
          Jason.encode!(%{
            errors: [
              %{
                code: "missing_authorization_material",
                message: "No authorization material provided in request"
              }
            ],
            request_id: "01FCNDV6P870EA6S7TK1DSYDG0",
            status: 401,
            type: "authentication_error"
          })
        )
      end)

      :ok
    end

    test "returns 401 on authentication failure" do
      assert {401, _, _} = list(@client)
    end

    test "returns error body on authentication failure" do
      {401, response, _} = list(@client)
      assert %{type: "authentication_error", status: 401} = response
    end
  end
end
