defmodule IncidentIo.PostMortemsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.PostMortemsV2

  doctest IncidentIo.PostMortemsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  @post_mortem_fixture %{
    created_at: "2021-08-17T13:28:57.801578Z",
    id: "01FCNDV6P870EA6S7TK1DSYDG0",
    incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
    name: "Incident post-mortem",
    updated_at: "2021-08-17T13:28:57.801578Z"
  }

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{post_mortems: [@post_mortem_fixture]})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected number of post mortems" do
      {200, %{post_mortems: post_mortems}, _} = list(@client)
      assert Enum.count(post_mortems) == 1
    end

    test "returns expected response" do
      {200, response, _} = list(@client)

      assert %{
               post_mortems: [
                 %{
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Incident post-mortem"
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
          Jason.encode!(%{post_mortem: @post_mortem_fixture})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} =
               create(@client, %{
                 incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Incident post-mortem"
               })
    end

    test "returns expected response" do
      {201, response, _} =
        create(@client, %{
          incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
          name: "Incident post-mortem"
        })

      assert %{
               post_mortem: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Incident post-mortem"
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
          Jason.encode!(%{post_mortem: @post_mortem_fixture})
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
               post_mortem: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Incident post-mortem"
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
            post_mortem: %{@post_mortem_fixture | name: "Updated post-mortem"}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} =
               update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Updated post-mortem"})
    end

    test "returns expected response" do
      {200, response, _} =
        update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Updated post-mortem"})

      assert %{post_mortem: %{name: "Updated post-mortem"}} = response
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
