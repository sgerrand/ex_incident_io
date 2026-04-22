defmodule IncidentIo.AlertsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.AlertsV2

  doctest IncidentIo.AlertsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  @alert_fixture %{
    created_at: "2021-08-17T13:28:57.801578Z",
    id: "01FCNDV6P870EA6S7TK1DSYDG0",
    status: "firing",
    title: "High error rate on api.example.com"
  }

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            alerts: [@alert_fixture],
            pagination_meta: %{after: nil, page_size: 25, total_record_count: 1}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected number of alerts" do
      {200, %{alerts: alerts}, _} = list(@client)
      assert Enum.count(alerts) == 1
    end

    test "returns expected response" do
      {200, response, _} = list(@client)

      assert %{
               alerts: [
                 %{
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   status: "firing",
                   title: "High error rate on api.example.com"
                 }
               ]
             } = response
    end
  end

  describe "list/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            alerts: [@alert_fixture],
            pagination_meta: %{after: nil, page_size: 50, total_record_count: 1}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client, page_size: 50)
    end

    test "returns expected response" do
      {200, response, _} = list(@client, page_size: 50)
      assert %{alerts: [_]} = response
    end
  end

  describe "create/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          201,
          Jason.encode!(%{alert: @alert_fixture})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} =
               create(@client, %{
                 title: "High error rate on api.example.com",
                 status: "firing"
               })
    end

    test "returns expected response" do
      {201, response, _} =
        create(@client, %{
          title: "High error rate on api.example.com",
          status: "firing"
        })

      assert %{
               alert: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 status: "firing",
                 title: "High error rate on api.example.com"
               }
             } = response
    end
  end

  describe "show/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{alert: @alert_fixture})
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
               alert: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 status: "firing",
                 title: "High error rate on api.example.com"
               }
             } = response
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
