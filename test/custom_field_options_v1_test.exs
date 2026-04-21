defmodule IncidentIo.CustomFieldOptionsV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.CustomFieldOptionsV1

  doctest IncidentIo.CustomFieldOptionsV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/3" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            custom_field_options: [
              %{
                custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                sort_key: 10,
                value: "Product"
              }
            ],
            pagination_meta: %{after: "01FCNDV6P870EA6S7TK1DSYDG0", page_size: 25}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns expected response" do
      {200, response, _} =
        list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

      assert %{
               custom_field_options: [
                 %{
                   custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   sort_key: 10,
                   value: "Product"
                 }
               ],
               pagination_meta: %{after: "01FCNDV6P870EA6S7TK1DSYDG0", page_size: 25}
             } == response
    end
  end

  describe "create/2" do
    @body %{
      custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
      sort_key: 10,
      value: "Product"
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          201,
          Jason.encode!(%{
            custom_field_option: %{
              custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              sort_key: 10,
              value: "Product"
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
               custom_field_option: %{
                 custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 sort_key: 10,
                 value: "Product"
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
            custom_field_option: %{
              custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              sort_key: 10,
              value: "Product"
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
               custom_field_option: %{
                 custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 sort_key: 10,
                 value: "Product"
               }
             } == response
    end
  end

  describe "update/3" do
    @body %{
      sort_key: 10,
      value: "Product"
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            custom_field_option: %{
              custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              sort_key: 10,
              value: "Product"
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
               custom_field_option: %{
                 custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 sort_key: 10,
                 value: "Product"
               }
             } == response
    end
  end
end
