defmodule IncidentIo.SchedulesV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.SchedulesV2

  doctest IncidentIo.SchedulesV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
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
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "with optional params" do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 200, "{}")
      end)

      assert {200, _, _} =
               list(@client,
                 after: "01FDAG4SAP5TYPT98WGR2N7W91",
                 page_size: 10
               )
    end

    test "returns expected response" do
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

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          201,
          Jason.encode!(%{
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

  describe "destroy/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 202, "")
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {202, _, _} = destroy(@client, "01G0J1EXE7AXZ2C93K61WBPYEH")
    end

    test "returns expected response" do
      {202, response, _} = destroy(@client, "01G0J1EXE7AXZ2C93K61WBPYEH")

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
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = show(@client, "01G0J1EXE7AXZ2C93K61WBPYEH")
    end

    test "returns expected response" do
      {200, response, _} = show(@client, "01G0J1EXE7AXZ2C93K61WBPYEH")

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

  describe "update/3" do
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

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
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
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = update(@client, "01G0J1EXE7AXZ2C93K61WBPYEH", @body)
    end

    test "returns expected response" do
      {200, response, _} = update(@client, "01G0J1EXE7AXZ2C93K61WBPYEH", @body)

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
