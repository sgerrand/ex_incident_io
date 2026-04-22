defmodule IncidentIo.CatalogTypesV3Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.CatalogTypesV3

  doctest IncidentIo.CatalogTypesV3

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  @catalog_type_fixture %{
    annotations: %{
      "incident.io/catalog-importer/id": "id-of-config"
    },
    color: "yellow",
    created_at: "2021-08-17T13:28:57.801578Z",
    description: "Represents Kubernetes clusters that we run inside of GKE.",
    estimated_count: 7,
    icon: "bolt",
    id: "01FCNDV6P870EA6S7TK1DSYDG0",
    is_editable: false,
    name: "Kubernetes Cluster",
    ranked: true,
    updated_at: "2021-08-17T13:28:57.801578Z"
  }

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{catalog_types: [@catalog_type_fixture]})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected number of catalog types" do
      {200, %{catalog_types: catalog_types}, _} = list(@client)
      assert Enum.count(catalog_types) == 1
    end

    test "returns expected response" do
      {200, response, _} = list(@client)

      assert %{
               catalog_types: [
                 %{
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Kubernetes Cluster"
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
          Jason.encode!(%{catalog_type: @catalog_type_fixture})
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} =
               create(@client, %{
                 description: "Represents Kubernetes clusters that we run inside of GKE.",
                 name: "Kubernetes Cluster"
               })
    end

    test "returns expected response" do
      {201, response, _} =
        create(@client, %{
          description: "Represents Kubernetes clusters that we run inside of GKE.",
          name: "Kubernetes Cluster"
        })

      assert %{
               catalog_type: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Kubernetes Cluster"
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
          Jason.encode!(%{catalog_type: @catalog_type_fixture})
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
               catalog_type: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Kubernetes Cluster"
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
            catalog_type: %{@catalog_type_fixture | name: "Updated Kubernetes Cluster"}
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} =
               update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{
                 name: "Updated Kubernetes Cluster"
               })
    end

    test "returns expected response" do
      {200, response, _} =
        update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{name: "Updated Kubernetes Cluster"})

      assert %{catalog_type: %{name: "Updated Kubernetes Cluster"}} = response
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
