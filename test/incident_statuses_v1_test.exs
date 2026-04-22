defmodule IncidentIo.IncidentStatusesV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentStatusesV1

  doctest IncidentIo.IncidentStatusesV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            incident_statuses: [
              %{
                category: "triage",
                created_at: "2021-08-17T13:28:57.801578Z",
                description:
                  "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                id: "01FCNDV6P870EA6S7TK1DSYD5H",
                name: "Closed",
                rank: 4,
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
               incident_statuses: [
                 %{
                   category: "triage",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description:
                     "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                   id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   name: "Closed",
                   rank: 4,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               ]
             } == response
    end
  end

  describe "create/2" do
    @body %{
      category: "live",
      description:
        "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
      name: "Closed"
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          201,
          Jason.encode!(%{
            incident_status: %{
              category: "triage",
              created_at: "2021-08-17T13:28:57.801578Z",
              description:
                "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
              id: "01FCNDV6P870EA6S7TK1DSYD5H",
              name: "Closed",
              rank: 4,
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
               incident_status: %{
                 category: "triage",
                 created_at: "2021-08-17T13:28:57.801578Z",
                 description:
                   "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                 id: "01FCNDV6P870EA6S7TK1DSYD5H",
                 name: "Closed",
                 rank: 4,
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
            incident_status: %{
              category: "triage",
              created_at: "2021-08-17T13:28:57.801578Z",
              description:
                "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
              id: "01FCNDV6P870EA6S7TK1DSYD5H",
              name: "Closed",
              rank: 4,
              updated_at: "2021-08-17T13:28:57.801578Z"
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYD5H")
    end

    test "returns expected response" do
      {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYD5H")

      assert %{
               incident_status: %{
                 category: "triage",
                 created_at: "2021-08-17T13:28:57.801578Z",
                 description:
                   "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                 id: "01FCNDV6P870EA6S7TK1DSYD5H",
                 name: "Closed",
                 rank: 4,
                 updated_at: "2021-08-17T13:28:57.801578Z"
               }
             } == response
    end
  end

  describe "update/3" do
    @body %{
      description: "The person currently coordinating the incident",
      instructions: "Take point on the incident; Make sure people are clear on responsibilities",
      name: "Incident Lead",
      required: false,
      shortform: "lead"
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            incident_status: %{
              category: "triage",
              created_at: "2021-08-17T13:28:57.801578Z",
              description:
                "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
              id: "01FCNDV6P870EA6S7TK1DSYD5H",
              name: "Closed",
              rank: 4,
              updated_at: "2021-08-17T13:28:57.801578Z"
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYD5H", @body)
    end

    test "returns expected response" do
      {200, response, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYD5H", @body)

      assert %{
               incident_status: %{
                 category: "triage",
                 created_at: "2021-08-17T13:28:57.801578Z",
                 description:
                   "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                 id: "01FCNDV6P870EA6S7TK1DSYD5H",
                 name: "Closed",
                 rank: 4,
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
