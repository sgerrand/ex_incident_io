defmodule IncidentIo.ApiKeysV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.ApiKeysV1

  doctest IncidentIo.ApiKeysV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  @api_key_fixture %{
    created_at: "2021-08-17T13:28:57.801578Z",
    expires_at: "2024-01-01T00:00:00.000000Z",
    id: "01FCNDV6P870EA6S7TK1DSYDG0",
    name: "My API Key",
    roles: ["viewer"]
  }

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            api_keys: [@api_key_fixture]
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected number of api keys" do
      {200, %{api_keys: api_keys}, _} = list(@client)
      assert Enum.count(api_keys) == 1
    end

    test "returns expected response" do
      {200, response, _} = list(@client)

      assert %{
               api_keys: [
                 %{
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "My API Key",
                   roles: ["viewer"]
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
          Jason.encode!(%{api_key: @api_key_fixture})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} = create(@client, %{name: "My API Key"})
    end

    test "returns expected response" do
      {201, response, _} = create(@client, %{name: "My API Key"})

      assert %{
               api_key: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "My API Key"
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
          Jason.encode!(%{api_key: @api_key_fixture})
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
               api_key: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "My API Key"
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
            api_key: %{@api_key_fixture | name: "Updated Key Name"}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} =
               update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Updated Key Name"})
    end

    test "returns expected response" do
      {200, response, _} =
        update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Updated Key Name"})

      assert %{api_key: %{name: "Updated Key Name"}} = response
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

  describe "rotate/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{api_key: @api_key_fixture})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = rotate(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns expected response" do
      {200, response, _} = rotate(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

      assert %{
               api_key: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0"
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
