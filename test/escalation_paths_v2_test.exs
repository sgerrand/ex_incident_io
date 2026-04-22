defmodule IncidentIo.EscalationPathsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.EscalationPathsV2

  doctest IncidentIo.EscalationPathsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  @escalation_path_fixture %{
    created_at: "2021-08-17T13:28:57.801578Z",
    id: "01FCNDV6P870EA6S7TK1DSYDG0",
    name: "Default Escalation Path",
    updated_at: "2021-08-17T13:28:57.801578Z"
  }

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{escalation_paths: [@escalation_path_fixture]})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected number of escalation paths" do
      {200, %{escalation_paths: escalation_paths}, _} = list(@client)
      assert Enum.count(escalation_paths) == 1
    end

    test "returns expected response" do
      {200, response, _} = list(@client)

      assert %{
               escalation_paths: [
                 %{
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Default Escalation Path"
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
          Jason.encode!(%{escalation_path: @escalation_path_fixture})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} = create(@client, %{name: "Default Escalation Path"})
    end

    test "returns expected response" do
      {201, response, _} = create(@client, %{name: "Default Escalation Path"})

      assert %{
               escalation_path: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Default Escalation Path"
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
          Jason.encode!(%{escalation_path: @escalation_path_fixture})
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
               escalation_path: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Default Escalation Path"
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
            escalation_path: %{@escalation_path_fixture | name: "Updated Escalation Path"}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} =
               update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{
                 name: "Updated Escalation Path"
               })
    end

    test "returns expected response" do
      {200, response, _} =
        update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Updated Escalation Path"})

      assert %{escalation_path: %{name: "Updated Escalation Path"}} = response
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
