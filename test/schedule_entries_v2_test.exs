defmodule IncidentIo.ScheduleEntriesV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.ScheduleEntriesV2

  doctest IncidentIo.ScheduleEntriesV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            pagination_meta: %{
              after: "abc123",
              after_url: "abc123"
            },
            schedule_entries: %{
              final: [
                %{
                  end_at: "2021-08-17T13:28:57.801578Z",
                  entry_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  fingerprint: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  layer_id: "01G0J1EXE7AXZ2C93K61WBPYNH",
                  rotation_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  start_at: "2021-08-17T13:28:57.801578Z",
                  user: %{
                    email: "lisa@incident.io",
                    id: "01FCNDV6P870EA6S7TK1DSYDG0",
                    name: "Lisa Karlin Curtis",
                    role: "viewer",
                    slack_user_id: "U02AYNF2XJM"
                  }
                }
              ],
              overrides: [
                %{
                  end_at: "2021-08-17T13:28:57.801578Z",
                  entry_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  fingerprint: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  layer_id: "01G0J1EXE7AXZ2C93K61WBPYNH",
                  rotation_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  start_at: "2021-08-17T13:28:57.801578Z",
                  user: %{
                    email: "lisa@incident.io",
                    id: "01FCNDV6P870EA6S7TK1DSYDG0",
                    name: "Lisa Karlin Curtis",
                    role: "viewer",
                    slack_user_id: "U02AYNF2XJM"
                  }
                }
              ],
              scheduled: [
                %{
                  end_at: "2021-08-17T13:28:57.801578Z",
                  entry_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  fingerprint: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  layer_id: "01G0J1EXE7AXZ2C93K61WBPYNH",
                  rotation_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  start_at: "2021-08-17T13:28:57.801578Z",
                  user: %{
                    email: "lisa@incident.io",
                    id: "01FCNDV6P870EA6S7TK1DSYDG0",
                    name: "Lisa Karlin Curtis",
                    role: "viewer",
                    slack_user_id: "U02AYNF2XJM"
                  }
                }
              ]
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client, "01FDAG4SAP5TYPT98WGR2N7W91")
    end

    test "with optional params" do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 200, "{}")
      end)

      assert {200, _, _} =
               list(@client, "01FDAG4SAP5TYPT98WGR2N7W91",
                 entry_window_start: "2021-01-01T00:00:00Z",
                 entry_window_end: "2021-01-02T00:00:00Z"
               )
    end

    test "returns expected response" do
      {200, response, _} = list(@client, "01FDAG4SAP5TYPT98WGR2N7W91")

      assert %{
               pagination_meta: %{
                 after: "abc123",
                 after_url: "abc123"
               },
               schedule_entries: %{
                 final: [
                   %{
                     end_at: "2021-08-17T13:28:57.801578Z",
                     entry_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                     fingerprint: "01G0J1EXE7AXZ2C93K61WBPYEH",
                     layer_id: "01G0J1EXE7AXZ2C93K61WBPYNH",
                     rotation_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                     start_at: "2021-08-17T13:28:57.801578Z",
                     user: %{
                       email: "lisa@incident.io",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Lisa Karlin Curtis",
                       role: "viewer",
                       slack_user_id: "U02AYNF2XJM"
                     }
                   }
                 ],
                 overrides: [
                   %{
                     end_at: "2021-08-17T13:28:57.801578Z",
                     entry_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                     fingerprint: "01G0J1EXE7AXZ2C93K61WBPYEH",
                     layer_id: "01G0J1EXE7AXZ2C93K61WBPYNH",
                     rotation_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                     start_at: "2021-08-17T13:28:57.801578Z",
                     user: %{
                       email: "lisa@incident.io",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Lisa Karlin Curtis",
                       role: "viewer",
                       slack_user_id: "U02AYNF2XJM"
                     }
                   }
                 ],
                 scheduled: [
                   %{
                     end_at: "2021-08-17T13:28:57.801578Z",
                     entry_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                     fingerprint: "01G0J1EXE7AXZ2C93K61WBPYEH",
                     layer_id: "01G0J1EXE7AXZ2C93K61WBPYNH",
                     rotation_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                     start_at: "2021-08-17T13:28:57.801578Z",
                     user: %{
                       email: "lisa@incident.io",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Lisa Karlin Curtis",
                       role: "viewer",
                       slack_user_id: "U02AYNF2XJM"
                     }
                   }
                 ]
               }
             } == response
    end
  end
end
