defmodule IncidentIo.IncidentsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentsV2

  doctest IncidentIo.IncidentsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "incidents_v2#list" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "incidents_v2#list" do
        {200, response, _} = list(@client)

        assert %{
                 incidents: [
                   %{
                     call_url: "https://zoom.us/foo",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     creator: %{
                       api_key: %{
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         name: "My test API key"
                       },
                       user: %{
                         email: "lisa@incident.io",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         name: "Lisa Karlin Curtis",
                         role: "viewer",
                         slack_user_id: "U02AYNF2XJM"
                       }
                     },
                     custom_field_entries: [
                       %{
                         custom_field: %{
                           description: "Which team is impacted by this issue",
                           field_type: "single_select",
                           id: "01FCNDV6P870EA6S7TK1DSYDG0",
                           name: "Affected Team",
                           options: [
                             %{
                               custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                               id: "01FCNDV6P870EA6S7TK1DSYDG0",
                               sort_key: 10,
                               value: "Product"
                             }
                           ]
                         },
                         values: [
                           %{
                             value_catalog_entry: %{
                               aliases: [
                                 "lawrence@incident.io",
                                 "lawrence"
                               ],
                               external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
                               id: "01FCNDV6P870EA6S7TK1DSYDG0",
                               name: "Primary On-call"
                             },
                             value_link: "https://google.com/",
                             value_numeric: "123.456",
                             value_option: %{
                               custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                               id: "01FCNDV6P870EA6S7TK1DSYDG0",
                               sort_key: 10,
                               value: "Product"
                             },
                             value_text: "This is my text field, I hope you like it"
                           }
                         ]
                       }
                     ],
                     duration_metrics: [
                       %{
                         duration_metric: %{
                           id: "01FCNDV6P870EA6S7TK1DSYD5H",
                           name: "Lasted"
                         },
                         value_seconds: 1
                       }
                     ],
                     external_issue_reference: %{
                       issue_name: "INC-123",
                       issue_permalink:
                         "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                       provider: "asana"
                     },
                     id: "01FDAG4SAP5TYPT98WGR2N7W91",
                     incident_role_assignments: [
                       %{
                         assignee: %{
                           email: "lisa@incident.io",
                           id: "01FCNDV6P870EA6S7TK1DSYDG0",
                           name: "Lisa Karlin Curtis",
                           role: "viewer",
                           slack_user_id: "U02AYNF2XJM"
                         },
                         role: %{
                           created_at: "2021-08-17T13:28:57.801578Z",
                           description: "The person currently coordinating the incident",
                           id: "01FCNDV6P870EA6S7TK1DSYDG0",
                           instructions:
                             "Take point on the incident; Make sure people are clear on responsibilities",
                           name: "Incident Lead",
                           required: false,
                           role_type: "lead",
                           shortform: "lead",
                           updated_at: "2021-08-17T13:28:57.801578Z"
                         }
                       }
                     ],
                     incident_status: %{
                       category: "triage",
                       created_at: "2021-08-17T13:28:57.801578Z",
                       description:
                         "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                       id: "01FCNDV6P870EA6S7TK1DSYD5H",
                       name: "Closed",
                       rank: 4,
                       updated_at: "2021-08-17T13:28:57.801578Z"
                     },
                     incident_timestamp_values: [
                       %{
                         incident_timestamp: %{
                           id: "01FCNDV6P870EA6S7TK1DSYD5H",
                           name: "Impact started",
                           rank: 1
                         },
                         value: %{
                           value: "2021-08-17T13:28:57.801578Z"
                         }
                       }
                     ],
                     incident_type: %{
                       create_in_triage: "always",
                       created_at: "2021-08-17T13:28:57.801578Z",
                       description: "Customer facing production outages",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       is_default: false,
                       name: "Production Outage",
                       private_incidents_only: false,
                       updated_at: "2021-08-17T13:28:57.801578Z"
                     },
                     mode: "standard",
                     name: "Our database is sad",
                     permalink: "https://app.incident.io/incidents/123",
                     postmortem_document_url: "https://docs.google.com/my_doc_id",
                     reference: "INC-123",
                     severity: %{
                       created_at: "2021-08-17T13:28:57.801578Z",
                       description: "Issues with **low impact**.",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Minor",
                       rank: 1,
                       updated_at: "2021-08-17T13:28:57.801578Z"
                     },
                     slack_channel_id: "C02AW36C1M5",
                     slack_channel_name: "inc-165-green-parrot",
                     slack_team_id: "T02A1FSLE8J",
                     summary: "Our database is really really sad, and we don't know why yet.",
                     updated_at: "2021-08-17T13:28:57.801578Z",
                     visibility: "public",
                     workload_minutes_late: 40.7,
                     workload_minutes_sleeping: 0,
                     workload_minutes_total: 60.7,
                     workload_minutes_working: 20
                   }
                 ],
                 pagination_meta: %{
                   after: "01FCNDV6P870EA6S7TK1DSYDG0",
                   page_size: 25,
                   total_record_count: 238
                 }
               } == response
      end
    end
  end

  describe "list/2 with optional query params" do
    test "with page_size" do
      use_cassette "incidents_v2#list-2" do
        assert {200, _, _} = list(@client, page_size: 20)
      end
    end

    test "with status" do
      use_cassette "incidents_v2#list-3" do
        assert {200, _, _} =
                 list(@client,
                   status: %{one_of: ["ABC", "zyx"]},
                   created_at: %{lte: ["2021-01-02", "2021-01-05"]},
                   status_category: %{one_of: ["closed", "live"]},
                   severity: %{gte: "ABC"}
                 )
      end
    end
  end

  describe "create/2" do
    @body %{
      custom_field_entries: [
        %{
          custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
          values: [
            %{
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              value_catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              value_link: "https://google.com/",
              value_numeric: "123.456",
              value_option_id: "01FCNDV6P870EA6S7TK1DSYDG0",
              value_text: "This is my text field, I hope you like it",
              value_timestamp: ""
            }
          ]
        }
      ],
      id: "01FDAG4SAP5TYPT98WGR2N7W91",
      idempotency_key: "alert-uuid",
      incident_role_assignments: [
        %{
          assignee: %{
            email: "bob@example.com",
            id: "01G0J1EXE7AXZ2C93K61WBPYEH",
            slack_user_id: "USER123"
          },
          incident_role_id: "01FH5TZRWMNAFB0DZ23FD1TV96"
        }
      ],
      incident_status_id: "01G0J1EXE7AXZ2C93K61WBPYEH",
      incident_timestamp_values: [
        %{
          incident_timestamp_id: "01FCNDV6P870EA6S7TK1DSYD5H",
          value: "2021-08-17T13:28:57.801578Z"
        }
      ],
      incident_type_id: "01FH5TZRWMNAFB0DZ23FD1TV96",
      mode: "standard",
      name: "Our database is sad",
      retrospective_incident_options: %{
        postmortem_document_url: "https://docs.google.com/my_doc_id",
        slack_channel_id: "abc123"
      },
      severity_id: "01FH5TZRWMNAFB0DZ23FD1TV96",
      slack_channel_name_override: "inc-123-database-down",
      slack_team_id: "T02A1FSLE8J",
      summary: "Our database is really really sad, and we don't know why yet.",
      visibility: "public"
    }

    test "returns expected HTTP status code" do
      use_cassette "incidents_v2#create" do
        assert {200, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "incidents_v2#create" do
        {200, response, _} = create(@client, @body)

        assert %{
                 incident: %{
                   call_url: "https://zoom.us/foo",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   creator: %{
                     api_key: %{
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "My test API key"
                     },
                     user: %{
                       email: "lisa@incident.io",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Lisa Karlin Curtis",
                       role: "viewer",
                       slack_user_id: "U02AYNF2XJM"
                     }
                   },
                   custom_field_entries: [
                     %{
                       custom_field: %{
                         description: "Which team is impacted by this issue",
                         field_type: "single_select",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         name: "Affected Team",
                         options: [
                           %{
                             custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             sort_key: 10,
                             value: "Product"
                           }
                         ]
                       },
                       values: [
                         %{
                           value_catalog_entry: %{
                             aliases: [
                               "lawrence@incident.io",
                               "lawrence"
                             ],
                             external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
                             id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             name: "Primary On-call"
                           },
                           value_link: "https://google.com/",
                           value_numeric: "123.456",
                           value_option: %{
                             custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             sort_key: 10,
                             value: "Product"
                           },
                           value_text: "This is my text field, I hope you like it"
                         }
                       ]
                     }
                   ],
                   duration_metrics: [
                     %{
                       duration_metric: %{
                         id: "01FCNDV6P870EA6S7TK1DSYD5H",
                         name: "Lasted"
                       },
                       value_seconds: 1
                     }
                   ],
                   external_issue_reference: %{
                     issue_name: "INC-123",
                     issue_permalink:
                       "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                     provider: "asana"
                   },
                   id: "01FDAG4SAP5TYPT98WGR2N7W91",
                   incident_role_assignments: [
                     %{
                       assignee: %{
                         email: "lisa@incident.io",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         name: "Lisa Karlin Curtis",
                         role: "viewer",
                         slack_user_id: "U02AYNF2XJM"
                       },
                       role: %{
                         created_at: "2021-08-17T13:28:57.801578Z",
                         description: "The person currently coordinating the incident",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         instructions:
                           "Take point on the incident; Make sure people are clear on responsibilities",
                         name: "Incident Lead",
                         required: false,
                         role_type: "lead",
                         shortform: "lead",
                         updated_at: "2021-08-17T13:28:57.801578Z"
                       }
                     }
                   ],
                   incident_status: %{
                     category: "triage",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description:
                       "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                     id: "01FCNDV6P870EA6S7TK1DSYD5H",
                     name: "Closed",
                     rank: 4,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   },
                   incident_timestamp_values: [
                     %{
                       incident_timestamp: %{
                         id: "01FCNDV6P870EA6S7TK1DSYD5H",
                         name: "Impact started",
                         rank: 1
                       },
                       value: %{
                         value: "2021-08-17T13:28:57.801578Z"
                       }
                     }
                   ],
                   incident_type: %{
                     create_in_triage: "always",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Customer facing production outages",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     is_default: false,
                     name: "Production Outage",
                     private_incidents_only: false,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   },
                   mode: "standard",
                   name: "Our database is sad",
                   permalink: "https://app.incident.io/incidents/123",
                   postmortem_document_url: "https://docs.google.com/my_doc_id",
                   reference: "INC-123",
                   severity: %{
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Issues with **low impact**.",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     name: "Minor",
                     rank: 1,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   },
                   slack_channel_id: "C02AW36C1M5",
                   slack_channel_name: "inc-165-green-parrot",
                   slack_team_id: "T02A1FSLE8J",
                   summary: "Our database is really really sad, and we don't know why yet.",
                   updated_at: "2021-08-17T13:28:57.801578Z",
                   visibility: "public",
                   workload_minutes_late: 40.7,
                   workload_minutes_sleeping: 0,
                   workload_minutes_total: 60.7,
                   workload_minutes_working: 20
                 }
               } == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "incidents_v2#show" do
        assert {200, _, _} = show(@client, "01FDAG4SAP5TYPT98WGR2N7W91")
      end
    end

    test "returns expected response" do
      use_cassette "incidents_v2#show" do
        {200, response, _} = show(@client, "01FDAG4SAP5TYPT98WGR2N7W91")

        assert %{
                 incident: %{
                   call_url: "https://zoom.us/foo",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   creator: %{
                     api_key: %{
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "My test API key"
                     },
                     user: %{
                       email: "lisa@incident.io",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Lisa Karlin Curtis",
                       role: "viewer",
                       slack_user_id: "U02AYNF2XJM"
                     }
                   },
                   custom_field_entries: [
                     %{
                       custom_field: %{
                         description: "Which team is impacted by this issue",
                         field_type: "single_select",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         name: "Affected Team",
                         options: [
                           %{
                             custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             sort_key: 10,
                             value: "Product"
                           }
                         ]
                       },
                       values: [
                         %{
                           value_catalog_entry: %{
                             aliases: [
                               "lawrence@incident.io",
                               "lawrence"
                             ],
                             external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
                             id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             name: "Primary On-call"
                           },
                           value_link: "https://google.com/",
                           value_numeric: "123.456",
                           value_option: %{
                             custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             sort_key: 10,
                             value: "Product"
                           },
                           value_text: "This is my text field, I hope you like it"
                         }
                       ]
                     }
                   ],
                   duration_metrics: [
                     %{
                       duration_metric: %{
                         id: "01FCNDV6P870EA6S7TK1DSYD5H",
                         name: "Lasted"
                       },
                       value_seconds: 1
                     }
                   ],
                   external_issue_reference: %{
                     issue_name: "INC-123",
                     issue_permalink:
                       "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                     provider: "asana"
                   },
                   id: "01FDAG4SAP5TYPT98WGR2N7W91",
                   incident_role_assignments: [
                     %{
                       assignee: %{
                         email: "lisa@incident.io",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         name: "Lisa Karlin Curtis",
                         role: "viewer",
                         slack_user_id: "U02AYNF2XJM"
                       },
                       role: %{
                         created_at: "2021-08-17T13:28:57.801578Z",
                         description: "The person currently coordinating the incident",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         instructions:
                           "Take point on the incident; Make sure people are clear on responsibilities",
                         name: "Incident Lead",
                         required: false,
                         role_type: "lead",
                         shortform: "lead",
                         updated_at: "2021-08-17T13:28:57.801578Z"
                       }
                     }
                   ],
                   incident_status: %{
                     category: "triage",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description:
                       "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                     id: "01FCNDV6P870EA6S7TK1DSYD5H",
                     name: "Closed",
                     rank: 4,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   },
                   incident_timestamp_values: [
                     %{
                       incident_timestamp: %{
                         id: "01FCNDV6P870EA6S7TK1DSYD5H",
                         name: "Impact started",
                         rank: 1
                       },
                       value: %{
                         value: "2021-08-17T13:28:57.801578Z"
                       }
                     }
                   ],
                   incident_type: %{
                     create_in_triage: "always",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Customer facing production outages",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     is_default: false,
                     name: "Production Outage",
                     private_incidents_only: false,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   },
                   mode: "standard",
                   name: "Our database is sad",
                   permalink: "https://app.incident.io/incidents/123",
                   postmortem_document_url: "https://docs.google.com/my_doc_id",
                   reference: "INC-123",
                   severity: %{
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Issues with **low impact**.",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     name: "Minor",
                     rank: 1,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   },
                   slack_channel_id: "C02AW36C1M5",
                   slack_channel_name: "inc-165-green-parrot",
                   slack_team_id: "T02A1FSLE8J",
                   summary: "Our database is really really sad, and we don't know why yet.",
                   updated_at: "2021-08-17T13:28:57.801578Z",
                   visibility: "public",
                   workload_minutes_late: 40.7,
                   workload_minutes_sleeping: 0,
                   workload_minutes_total: 60.7,
                   workload_minutes_working: 20
                 }
               } == response
      end
    end
  end

  describe "update/3" do
    @body %{
      incident: %{
        call_url: "https://zoom.us/foo",
        custom_field_entries: [
          %{
            custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
            values: [
              %{
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                value_catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                value_link: "https://google.com/",
                value_numeric: "123.456",
                value_option_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                value_text: "This is my text field, I hope you like it",
                value_timestamp: ""
              }
            ]
          }
        ],
        incident_role_assignments: [
          %{
            assignee: %{
              email: "bob@example.com",
              id: "01G0J1EXE7AXZ2C93K61WBPYEH",
              slack_user_id: "USER123"
            },
            incident_role_id: "01FH5TZRWMNAFB0DZ23FD1TV96"
          }
        ],
        incident_status_id: "01FH5TZRWMNAFB0DZ23FD1TV96",
        incident_timestamp_values: [
          %{
            incident_timestamp_id: "01FCNDV6P870EA6S7TK1DSYD5H",
            value: "2021-08-17T13:28:57.801578Z"
          }
        ],
        name: "Our database is sad",
        severity_id: "01FH5TZRWMNAFB0DZ23FD1TV96",
        summary: "Our database is really really sad, and we don't know why yet."
      },
      notify_incident_channel: true
    }

    test "returns expected HTTP status code" do
      use_cassette "incidents_v2#edit" do
        assert {200, _, _} = update(@client, "01G18REBY9AYH6CMWCJ2CVCYCH", @body)
      end
    end

    test "returns expected response" do
      use_cassette "incidents_v2#edit" do
        {200, response, _} = update(@client, "01G18REBY9AYH6CMWCJ2CVCYCH", @body)

        assert %{
                 incident: %{
                   call_url: "https://zoom.us/foo",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   creator: %{
                     api_key: %{
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "My test API key"
                     },
                     user: %{
                       email: "lisa@incident.io",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Lisa Karlin Curtis",
                       role: "viewer",
                       slack_user_id: "U02AYNF2XJM"
                     }
                   },
                   custom_field_entries: [
                     %{
                       custom_field: %{
                         description: "Which team is impacted by this issue",
                         field_type: "single_select",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         name: "Affected Team",
                         options: [
                           %{
                             custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             sort_key: 10,
                             value: "Product"
                           }
                         ]
                       },
                       values: [
                         %{
                           value_catalog_entry: %{
                             aliases: [
                               "lawrence@incident.io",
                               "lawrence"
                             ],
                             external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
                             id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             name: "Primary On-call"
                           },
                           value_link: "https://google.com/",
                           value_numeric: "123.456",
                           value_option: %{
                             custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             sort_key: 10,
                             value: "Product"
                           },
                           value_text: "This is my text field, I hope you like it"
                         }
                       ]
                     }
                   ],
                   duration_metrics: [
                     %{
                       duration_metric: %{
                         id: "01FCNDV6P870EA6S7TK1DSYD5H",
                         name: "Lasted"
                       },
                       value_seconds: 1
                     }
                   ],
                   external_issue_reference: %{
                     issue_name: "INC-123",
                     issue_permalink:
                       "https://linear.app/incident-io/issue/INC-1609/find-copywriter-to-write-up",
                     provider: "asana"
                   },
                   id: "01FDAG4SAP5TYPT98WGR2N7W91",
                   incident_role_assignments: [
                     %{
                       assignee: %{
                         email: "lisa@incident.io",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         name: "Lisa Karlin Curtis",
                         role: "viewer",
                         slack_user_id: "U02AYNF2XJM"
                       },
                       role: %{
                         created_at: "2021-08-17T13:28:57.801578Z",
                         description: "The person currently coordinating the incident",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         instructions:
                           "Take point on the incident; Make sure people are clear on responsibilities",
                         name: "Incident Lead",
                         required: false,
                         role_type: "lead",
                         shortform: "lead",
                         updated_at: "2021-08-17T13:28:57.801578Z"
                       }
                     }
                   ],
                   incident_status: %{
                     category: "triage",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description:
                       "Impact has been **fully mitigated**, and we're ready to learn from this incident.",
                     id: "01FCNDV6P870EA6S7TK1DSYD5H",
                     name: "Closed",
                     rank: 4,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   },
                   incident_timestamp_values: [
                     %{
                       incident_timestamp: %{
                         id: "01FCNDV6P870EA6S7TK1DSYD5H",
                         name: "Impact started",
                         rank: 1
                       },
                       value: %{
                         value: "2021-08-17T13:28:57.801578Z"
                       }
                     }
                   ],
                   incident_type: %{
                     create_in_triage: "always",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Customer facing production outages",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     is_default: false,
                     name: "Production Outage",
                     private_incidents_only: false,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   },
                   mode: "standard",
                   name: "Our database is sad",
                   permalink: "https://app.incident.io/incidents/123",
                   postmortem_document_url: "https://docs.google.com/my_doc_id",
                   reference: "INC-123",
                   severity: %{
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Issues with **low impact**.",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     name: "Minor",
                     rank: 1,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   },
                   slack_channel_id: "C02AW36C1M5",
                   slack_channel_name: "inc-165-green-parrot",
                   slack_team_id: "T02A1FSLE8J",
                   summary: "Our database is really really sad, and we don't know why yet.",
                   updated_at: "2021-08-17T13:28:57.801578Z",
                   visibility: "public",
                   workload_minutes_late: 40.7,
                   workload_minutes_sleeping: 0,
                   workload_minutes_total: 60.7,
                   workload_minutes_working: 20
                 }
               } == response
      end
    end
  end
end
