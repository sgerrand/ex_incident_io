defmodule IncidentIo.CatalogEntriesV3Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.CatalogEntriesV3

  doctest IncidentIo.CatalogEntriesV3

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  @catalog_entry_fixture %{
    aliases: ["lawrence@incident.io", "lawrence"],
    attribute_values: %{
      abc123: %{
        array_value: [%{literal: "SEV123", reference: "incident.severity"}],
        value: %{literal: "SEV123", reference: "incident.severity"}
      }
    },
    catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
    created_at: "2021-08-17T13:28:57.801578Z",
    external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
    id: "01FCNDV6P870EA6S7TK1DSYDG0",
    name: "Primary On-call",
    rank: 3,
    updated_at: "2021-08-17T13:28:57.801578Z"
  }

  describe "list/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            catalog_entries: [@catalog_entry_fixture],
            pagination_meta: %{after: nil, page_size: 25, total_record_count: 1}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns expected number of catalog entries" do
      {200, %{catalog_entries: catalog_entries}, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      assert Enum.count(catalog_entries) == 1
    end

    test "returns expected response" do
      {200, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

      assert %{
               catalog_entries: [
                 %{
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Primary On-call"
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
          Jason.encode!(%{catalog_entry: @catalog_entry_fixture})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} =
               create(@client, %{
                 aliases: ["lawrence@incident.io"],
                 attribute_values: %{},
                 catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
                 name: "Primary On-call",
                 rank: 3
               })
    end

    test "returns expected response" do
      {201, response, _} =
        create(@client, %{
          aliases: ["lawrence@incident.io"],
          attribute_values: %{},
          catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
          external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
          name: "Primary On-call",
          rank: 3
        })

      assert %{
               catalog_entry: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Primary On-call"
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
          Jason.encode!(%{catalog_entry: @catalog_entry_fixture})
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
               catalog_entry: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Primary On-call"
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
            catalog_entry: %{@catalog_entry_fixture | name: "Was Primary On-call", rank: 5}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} =
               update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{
                 name: "Was Primary On-call",
                 rank: 5
               })
    end

    test "returns expected response" do
      {200, response, _} =
        update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Was Primary On-call", rank: 5})

      assert %{catalog_entry: %{name: "Was Primary On-call", rank: 5}} = response
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
      assert {401, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns error body on authentication failure" do
      {401, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      assert %{type: "authentication_error", status: 401} = response
    end
  end
end
