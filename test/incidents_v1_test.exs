defmodule IncidentIo.IncidentsV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentsV1

  doctest IncidentIo.IncidentsV1

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "incidents_v1#list" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "incidents_v1#list" do
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
                     mode: "real",
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
                     status: "triage",
                     summary: "Our database is really really sad, and we don't know why yet.",
                     timestamps: [
                       %{
                         last_occurred_at: "2021-08-17T13:28:57.801578Z",
                         name: "last_activity"
                       }
                     ],
                     updated_at: "2021-08-17T13:28:57.801578Z",
                     visibility: "public"
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
      incident_type_id: "01FH5TZRWMNAFB0DZ23FD1TV96",
      mode: "real",
      name: "Our database is sad",
      severity_id: "01FH5TZRWMNAFB0DZ23FD1TV96",
      slack_team_id: "T02A1FSLE8J",
      source_message_channel_id: "C02AW36C1M5",
      source_message_timestamp: "1653650280.526509",
      status: "triage",
      summary: "Our database is really really sad, and we don't know why yet.",
      visibility: "public"
    }

    test "returns expected HTTP status code" do
      use_cassette "incidents_v1#create" do
        assert {200, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "incidents_v1#create" do
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
                   mode: "real",
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
                   status: "triage",
                   summary: "Our database is really really sad, and we don't know why yet.",
                   timestamps: [
                     %{
                       last_occurred_at: "2021-08-17T13:28:57.801578Z",
                       name: "last_activity"
                     }
                   ],
                   updated_at: "2021-08-17T13:28:57.801578Z",
                   visibility: "public"
                 }
               } == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "incidents_v1#show" do
        assert {200, _, _} = show(@client, "01FDAG4SAP5TYPT98WGR2N7W91")
      end
    end

    test "returns expected response" do
      use_cassette "incidents_v1#show" do
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
                   mode: "real",
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
                   status: "triage",
                   summary: "Our database is really really sad, and we don't know why yet.",
                   timestamps: [
                     %{
                       last_occurred_at: "2021-08-17T13:28:57.801578Z",
                       name: "last_activity"
                     }
                   ],
                   updated_at: "2021-08-17T13:28:57.801578Z",
                   visibility: "public"
                 }
               } == response
      end
    end
  end
end
