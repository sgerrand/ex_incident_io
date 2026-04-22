defmodule IncidentIo.MaintenanceWindowsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.MaintenanceWindowsV2

  doctest IncidentIo.MaintenanceWindowsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  @maintenance_window_fixture %{
    created_at: "2021-08-17T13:28:57.801578Z",
    ends_at: "2021-08-17T14:28:57.801578Z",
    id: "01FCNDV6P870EA6S7TK1DSYDG0",
    name: "Weekly maintenance",
    starts_at: "2021-08-17T13:28:57.801578Z"
  }

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{maintenance_windows: [@maintenance_window_fixture]})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected number of maintenance windows" do
      {200, %{maintenance_windows: maintenance_windows}, _} = list(@client)
      assert Enum.count(maintenance_windows) == 1
    end

    test "returns expected response" do
      {200, response, _} = list(@client)

      assert %{
               maintenance_windows: [
                 %{
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Weekly maintenance"
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
          Jason.encode!(%{maintenance_window: @maintenance_window_fixture})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} =
               create(@client, %{
                 name: "Weekly maintenance",
                 starts_at: "2021-08-17T13:00:00.000000Z",
                 ends_at: "2021-08-17T14:00:00.000000Z"
               })
    end

    test "returns expected response" do
      {201, response, _} =
        create(@client, %{
          name: "Weekly maintenance",
          starts_at: "2021-08-17T13:00:00.000000Z",
          ends_at: "2021-08-17T14:00:00.000000Z"
        })

      assert %{
               maintenance_window: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Weekly maintenance"
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
          Jason.encode!(%{maintenance_window: @maintenance_window_fixture})
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
               maintenance_window: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Weekly maintenance"
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
            maintenance_window: %{@maintenance_window_fixture | name: "Updated maintenance"}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} =
               update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Updated maintenance"})
    end

    test "returns expected response" do
      {200, response, _} =
        update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Updated maintenance"})

      assert %{maintenance_window: %{name: "Updated maintenance"}} = response
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
