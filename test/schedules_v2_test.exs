defmodule IncidentIo.SchedulesV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.SchedulesV2

  doctest IncidentIo.SchedulesV2

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "schedules#list" do
        assert {200, _, _} = list(@client)
      end
    end

    test "with optional params" do
      use_cassette "schedules#list-2" do
        assert {200, _, _} =
                 list(@client,
                   after: "01FDAG4SAP5TYPT98WGR2N7W91",
                   page_size: 10
                 )
      end
    end

    test "returns expected response" do
      use_cassette "schedules#list" do
        {200, response, _} = list(@client)

        assert %{
                 pagination_meta: %{
                   after: "01FCNDV6P870EA6S7TK1DSYDG0",
                   page_size: 25,
                   total_record_count: 238
                 },
                 schedules: [
                   %{
                     annotations: %{
                       "incident.io/terraform/version": "3.0.0"
                     },
                     config: %{
                       rotations: [
                         %{
                           effective_from: "2021-08-17T13:28:57.801578Z",
                           handover_start_at: "2021-08-17T13:28:57.801578Z",
                           handovers: [
                             %{
                               interval: 1,
                               interval_type: "daily"
                             }
                           ],
                           id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                           layers: [
                             %{
                               id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                               name: "Layer 1"
                             }
                           ],
                           name: "Primary On-Call Schedule",
                           users: [
                             %{
                               email: "lisa@incident.io",
                               id: "01FCNDV6P870EA6S7TK1DSYDG0",
                               name: "Lisa Karlin Curtis",
                               role: "viewer",
                               slack_user_id: "U02AYNF2XJM"
                             }
                           ],
                           working_interval: [
                             %{
                               end_time: "17:00",
                               start_time: "09:00",
                               weekday: "tuesday"
                             }
                           ]
                         }
                       ]
                     },
                     created_at: "2021-08-17T13:28:57.801578Z",
                     current_shifts: [
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
                     id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                     name: "Primary On-Call Schedule",
                     timezone: "Europe/London",
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   }
                 ]
               } == response
      end
    end
  end

  describe "create/2" do
    @body %{
      schedule: %{
        annotations: %{
          "incident.io/terraform/version": "version-of-terraform"
        },
        config: %{
          rotations: [
            %{
              effective_from: "2021-08-17T13:28:57.801578Z",
              handover_start_at: "2021-08-17T13:28:57.801578Z",
              handovers: [
                %{
                  interval: 1,
                  interval_type: "daily"
                }
              ],
              id: "01G0J1EXE7AXZ2C93K61WBPYEH",
              layers: [
                %{
                  id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  name: "Layer 1"
                }
              ],
              name: "My Rotation",
              users: [
                %{
                  email: "bob@example.com",
                  id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                  slack_user_id: "USER123"
                }
              ],
              working_interval: [
                %{
                  end_time: "17:00",
                  start_time: "09:00",
                  weekday: "tuesday"
                }
              ]
            }
          ]
        },
        name: "My Schedule",
        timezone: "America/Los_Angeles"
      }
    }

    test "returns expected HTTP status code" do
      use_cassette "schedules#create" do
        assert {200, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "schedules#create" do
        {200, response, _} = create(@client, @body)

        assert %{
                 schedule: %{
                   annotations: %{
                     "incident.io/terraform/version": "3.0.0"
                   },
                   config: %{
                     rotations: [
                       %{
                         effective_from: "2021-08-17T13:28:57.801578Z",
                         handover_start_at: "2021-08-17T13:28:57.801578Z",
                         handovers: [
                           %{
                             interval: 1,
                             interval_type: "daily"
                           }
                         ],
                         id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                         layers: [
                           %{
                             id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                             name: "Layer 1"
                           }
                         ],
                         name: "Primary On-Call Schedule",
                         users: [
                           %{
                             email: "lisa@incident.io",
                             id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             name: "Lisa Karlin Curtis",
                             role: "viewer",
                             slack_user_id: "U02AYNF2XJM"
                           }
                         ],
                         working_interval: [
                           %{
                             end_time: "17:00",
                             start_time: "09:00",
                             weekday: "tuesday"
                           }
                         ]
                       }
                     ]
                   },
                   created_at: "2021-08-17T13:28:57.801578Z",
                   current_shifts: [
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
                   id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                   name: "Primary On-Call Schedule",
                   timezone: "Europe/London",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end

  describe "destroy/2" do
    test "returns expected HTTP status code" do
      use_cassette "schedules#destroy" do
        assert {202, _, _} = destroy(@client, "01G0J1EXE7AXZ2C93K61WBPYEH")
      end
    end

    test "returns expected response" do
      use_cassette "schedules#destroy" do
        {202, response, _} = destroy(@client, "01G0J1EXE7AXZ2C93K61WBPYEH")

        assert nil == response
      end
    end
  end
end
