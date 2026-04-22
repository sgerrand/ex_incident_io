defmodule IncidentIo.ActionsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.ActionsV2

  doctest IncidentIo.ActionsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/3" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            actions: [
              %{
                assignee: %{
                  email: "lisa@incident.io",
                  id: "01FCNDV6P870EA6S7TK1DSYDG0",
                  name: "Lisa Karlin Curtis",
                  role: "viewer",
                  slack_user_id: "U02AYNF2XJM"
                },
                completed_at: "2021-08-17T13:28:57.801578Z",
                created_at: "2021-08-17T13:28:57.801578Z",
                description: "Call the fire brigade",
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                status: "outstanding",
                updated_at: "2021-08-17T13:28:57.801578Z"
              }
            ]
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)
    end

    test "returns expected number of actions" do
      {200, %{actions: actions}, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)
      assert Enum.count(actions) == 1
    end

    test "returns expected response" do
      {200, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)

      assert %{
               actions: [
                 %{
                   assignee: %{
                     email: "lisa@incident.io",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     name: "Lisa Karlin Curtis",
                     role: "viewer",
                     slack_user_id: "U02AYNF2XJM"
                   },
                   completed_at: "2021-08-17T13:28:57.801578Z",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Call the fire brigade",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   status: "outstanding",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               ]
             } == response
    end
  end

  describe "show/3" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            action: %{
              assignee: %{
                email: "lisa@incident.io",
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                name: "Lisa Karlin Curtis",
                role: "viewer",
                slack_user_id: "U02AYNF2XJM"
              },
              completed_at: "2021-08-17T13:28:57.801578Z",
              created_at: "2021-08-17T13:28:57.801578Z",
              description: "Call the fire brigade",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              status: "outstanding",
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

    test "returns expected attributes for action" do
      {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

      assert %{
               action: %{
                 assignee: %{
                   email: "lisa@incident.io",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Lisa Karlin Curtis",
                   role: "viewer",
                   slack_user_id: "U02AYNF2XJM"
                 },
                 completed_at: "2021-08-17T13:28:57.801578Z",
                 created_at: "2021-08-17T13:28:57.801578Z",
                 description: "Call the fire brigade",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 status: "outstanding",
                 updated_at: "2021-08-17T13:28:57.801578Z"
               }
             } == response
    end
  end

  describe "create/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          201,
          Jason.encode!(%{
            action: %{
              assignee: %{
                email: "lisa@incident.io",
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                name: "Lisa Karlin Curtis",
                role: "viewer",
                slack_user_id: "U02AYNF2XJM"
              },
              completed_at: "2021-08-17T13:28:57.801578Z",
              created_at: "2021-08-17T13:28:57.801578Z",
              description: "Call the fire brigade",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              status: "outstanding",
              updated_at: "2021-08-17T13:28:57.801578Z"
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} =
               create(@client, %{
                 assignee_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 description: "Call the fire brigade",
                 incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 status: "outstanding"
               })
    end

    test "returns expected response" do
      {201, response, _} =
        create(@client, %{
          assignee_id: "01FCNDV6P870EA6S7TK1DSYDG0",
          description: "Call the fire brigade",
          incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
          status: "outstanding"
        })

      assert %{
               action: %{
                 description: "Call the fire brigade",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 status: "outstanding"
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
            action: %{
              assignee: %{
                email: "lisa@incident.io",
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                name: "Lisa Karlin Curtis",
                role: "viewer",
                slack_user_id: "U02AYNF2XJM"
              },
              completed_at: "2021-08-17T13:28:57.801578Z",
              created_at: "2021-08-17T13:28:57.801578Z",
              description: "Call the fire brigade",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              status: "completed",
              updated_at: "2021-08-17T13:28:57.801578Z"
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} =
               update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{status: "completed"})
    end

    test "returns expected response" do
      {200, response, _} =
        update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", %{status: "completed"})

      assert %{
               action: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 status: "completed"
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
      assert {401, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns error body on authentication failure" do
      {401, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      assert %{type: "authentication_error", status: 401} = response
    end
  end
end
