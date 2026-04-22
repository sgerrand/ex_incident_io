defmodule IncidentIo.SeveritiesV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.SeveritiesV1

  doctest IncidentIo.SeveritiesV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
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

  describe "create/2" do
    @body %{
      description: "Issues with **low impact**.",
      name: "Minor",
      rank: 1
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          201,
          Jason.encode!(%{
            severity: %{
              created_at: "2021-08-17T13:28:57.801578Z",
              description: "Issues with **low impact**.",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              name: "Minor",
              rank: 1,
              updated_at: "2021-08-17T13:28:57.801578Z"
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} = create(@client, @body)
    end

    test "returns expected response" do
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

  describe "destroy/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 202, "")
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {202, _, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns expected response" do
      {202, response, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

      assert nil == response
    end
  end

  describe "show/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            severity: %{
              created_at: "2021-08-17T13:28:57.801578Z",
              description: "Issues with **low impact**.",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              name: "Minor",
              rank: 1,
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

  describe "update/3" do
    @body %{
      description: "Issues with **low impact**.",
      name: "Minor",
      rank: 1
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            severity: %{
              created_at: "2021-08-17T13:28:57.801578Z",
              description: "Issues with **low impact**.",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              name: "Minor",
              rank: 1,
              updated_at: "2021-08-17T13:28:57.801578Z"
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = update(@client, "01G0J1EXE7AXZ2C93K61WBPYEH", @body)
    end

    test "returns expected response" do
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
