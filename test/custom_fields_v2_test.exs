defmodule IncidentIo.CustomFieldsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.CustomFieldsV2

  doctest IncidentIo.CustomFieldsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            custom_fields: [
              %{
                catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                created_at: "2021-08-17T13:28:57.801578Z",
                description: "Which team is impacted by this issue",
                field_type: "single_select",
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                name: "Affected Team",
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
               custom_fields: [
                 %{
                   catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Which team is impacted by this issue",
                   field_type: "single_select",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Affected Team",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               ]
             } == response
    end
  end

  describe "create/2" do
    @body %{
      description: "Which team is impacted by this issue",
      field_type: "single_select",
      name: "Affected Team"
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          201,
          Jason.encode!(%{
            custom_field: %{
              catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              created_at: "2021-08-17T13:28:57.801578Z",
              description: "Which team is impacted by this issue",
              field_type: "single_select",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              name: "Affected Team",
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
      {201, response, _} =
        create(@client, @body)

      assert %{
               custom_field: %{
                 catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 created_at: "2021-08-17T13:28:57.801578Z",
                 description: "Which team is impacted by this issue",
                 field_type: "single_select",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Affected Team",
                 updated_at: "2021-08-17T13:28:57.801578Z"
               }
             } == response
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

    test "returns expected response" do
      {204, response, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

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
            custom_field: %{
              catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              created_at: "2021-08-17T13:28:57.801578Z",
              description: "Which team is impacted by this issue",
              field_type: "single_select",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              name: "Affected Team",
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
               custom_field: %{
                 catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 created_at: "2021-08-17T13:28:57.801578Z",
                 description: "Which team is impacted by this issue",
                 field_type: "single_select",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Affected Team",
                 updated_at: "2021-08-17T13:28:57.801578Z"
               }
             } == response
    end
  end

  describe "update/3" do
    @body %{
      description: "Which team is impacted by this issue",
      name: "Affected Team"
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            custom_field: %{
              catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              created_at: "2021-08-17T13:28:57.801578Z",
              description: "Which team is impacted by this issue",
              field_type: "single_select",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              name: "Affected Team",
              updated_at: "2021-08-17T13:28:57.801578Z"
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)
    end

    test "returns expected response" do
      {200, response, _} =
        update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)

      assert %{
               custom_field: %{
                 catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 created_at: "2021-08-17T13:28:57.801578Z",
                 description: "Which team is impacted by this issue",
                 field_type: "single_select",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Affected Team",
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
