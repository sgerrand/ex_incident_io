defmodule IncidentIo.FollowUpsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.FollowUpsV2

  doctest IncidentIo.FollowUpsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            follow_ups: [
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
                external_issue_reference: %{
                  issue_name: "INC-123",
                  issue_permalink:
                    "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                  provider: "asana"
                },
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                priority: %{
                  description: "A follow-up that requires immediate attention.",
                  id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                  name: "Urgent",
                  rank: 10
                },
                status: "outstanding",
                title: "Cat is stuck in the tree",
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
               follow_ups: [
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
                   external_issue_reference: %{
                     issue_name: "INC-123",
                     issue_permalink:
                       "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                     provider: "asana"
                   },
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   priority: %{
                     description: "A follow-up that requires immediate attention.",
                     id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                     name: "Urgent",
                     rank: 10
                   },
                   status: "outstanding",
                   title: "Cat is stuck in the tree",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               ]
             } == response
    end
  end

  describe "list/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            follow_ups: [
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
                external_issue_reference: %{
                  issue_name: "INC-123",
                  issue_permalink:
                    "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                  provider: "asana"
                },
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                priority: %{
                  description: "A follow-up that requires immediate attention.",
                  id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                  name: "Urgent",
                  rank: 10
                },
                status: "outstanding",
                title: "Cat is stuck in the tree",
                updated_at: "2021-08-17T13:28:57.801578Z"
              }
            ]
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns expected response" do
      {200, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

      assert %{
               follow_ups: [
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
                   external_issue_reference: %{
                     issue_name: "INC-123",
                     issue_permalink:
                       "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                     provider: "asana"
                   },
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   priority: %{
                     description: "A follow-up that requires immediate attention.",
                     id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                     name: "Urgent",
                     rank: 10
                   },
                   status: "outstanding",
                   title: "Cat is stuck in the tree",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               ]
             } == response
    end
  end

  describe "list/3" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            follow_ups: [
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
                external_issue_reference: %{
                  issue_name: "INC-123",
                  issue_permalink:
                    "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                  provider: "asana"
                },
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                priority: %{
                  description: "A follow-up that requires immediate attention.",
                  id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                  name: "Urgent",
                  rank: 10
                },
                status: "outstanding",
                title: "Cat is stuck in the tree",
                updated_at: "2021-08-17T13:28:57.801578Z"
              }
            ]
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", :standard)
    end

    test "returns expected response" do
      {200, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", :standard)

      assert %{
               follow_ups: [
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
                   external_issue_reference: %{
                     issue_name: "INC-123",
                     issue_permalink:
                       "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                     provider: "asana"
                   },
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   priority: %{
                     description: "A follow-up that requires immediate attention.",
                     id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                     name: "Urgent",
                     rank: 10
                   },
                   status: "outstanding",
                   title: "Cat is stuck in the tree",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               ]
             } == response
    end
  end

  describe "show/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            follow_up: %{
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
              external_issue_reference: %{
                issue_name: "INC-123",
                issue_permalink:
                  "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                provider: "asana"
              },
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              priority: %{
                description: "A follow-up that requires immediate attention.",
                id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                name: "Urgent",
                rank: 10
              },
              status: "outstanding",
              title: "Cat is stuck in the tree",
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
               follow_up: %{
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
                 external_issue_reference: %{
                   issue_name: "INC-123",
                   issue_permalink:
                     "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                   provider: "asana"
                 },
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 priority: %{
                   description: "A follow-up that requires immediate attention.",
                   id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                   name: "Urgent",
                   rank: 10
                 },
                 status: "outstanding",
                 title: "Cat is stuck in the tree",
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
            follow_up: %{
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
              external_issue_reference: %{
                issue_name: "INC-123",
                issue_permalink:
                  "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                provider: "asana"
              },
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              priority: %{
                description: "A follow-up that requires immediate attention.",
                id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                name: "Urgent",
                rank: 10
              },
              status: "outstanding",
              title: "Cat is stuck in the tree",
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
                 description: "Call the fire brigade",
                 incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 status: "outstanding",
                 title: "Cat is stuck in the tree"
               })
    end

    test "returns expected response" do
      {201, response, _} =
        create(@client, %{
          description: "Call the fire brigade",
          incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
          status: "outstanding",
          title: "Cat is stuck in the tree"
        })

      assert %{
               follow_up: %{
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 status: "outstanding",
                 title: "Cat is stuck in the tree"
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
            follow_up: %{
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
              external_issue_reference: %{
                issue_name: "INC-123",
                issue_permalink:
                  "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                provider: "asana"
              },
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              priority: %{
                description: "A follow-up that requires immediate attention.",
                id: "01GNW4BAQ7XRMFF6FHKNXDFPRW",
                name: "Urgent",
                rank: 10
              },
              status: "completed",
              title: "Cat is stuck in the tree",
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
               follow_up: %{
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
      assert {401, _, _} = list(@client)
    end

    test "returns error body on authentication failure" do
      {401, response, _} = list(@client)
      assert %{type: "authentication_error", status: 401} = response
    end
  end
end
