defmodule IncidentIo.AlertRoutesV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.AlertRoutesV2

  doctest IncidentIo.AlertRoutesV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  @alert_route_fixture %{
    created_at: "2021-08-17T13:28:57.801578Z",
    id: "01FCNDV6P870EA6S7TK1DSYDG0",
    name: "Production alerts",
    updated_at: "2021-08-17T13:28:57.801578Z"
  }

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{alert_routes: [@alert_route_fixture]})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected number of alert routes" do
      {200, %{alert_routes: alert_routes}, _} = list(@client)
      assert Enum.count(alert_routes) == 1
    end

    test "returns expected response" do
      {200, response, _} = list(@client)

      assert %{
               alert_routes: [
                 %{
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Production alerts"
                 }
               ]
             } = response
    end
  end

  describe "create/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          201,
          Jason.encode!(%{alert_route: @alert_route_fixture})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} = create(@client, %{name: "Production alerts"})
    end

    test "returns expected response" do
      {201, response, _} = create(@client, %{name: "Production alerts"})

      assert %{
               alert_route: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Production alerts"
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
          Jason.encode!(%{alert_route: @alert_route_fixture})
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
               alert_route: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Production alerts"
               }
             } = response
    end
  end

  describe "update/3" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            alert_route: %{@alert_route_fixture | name: "Updated route"}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} =
               update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Updated route"})
    end

    test "returns expected response" do
      {200, response, _} =
        update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Updated route"})

      assert %{alert_route: %{name: "Updated route"}} = response
    end
  end

  describe "destroy/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 204, "")
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {204, _, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns nil body" do
      {204, response, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      assert is_nil(response)
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
