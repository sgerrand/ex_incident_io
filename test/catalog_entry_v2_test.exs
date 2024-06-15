defmodule IncidentIo.CatalogEntryV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.CatalogEntryV2

  doctest IncidentIo.CatalogEntryV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/3" do
    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#list_entries" do
        assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)
      end
    end

    test "returns expected number of catalog_entries" do
      use_cassette "catalog_v2#list_entries" do
        {200, %{catalog_entries: catalog_entries}, _} =
          list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)

        assert Enum.count(catalog_entries) == 1
      end
    end

    test "returns expected response" do
      use_cassette "catalog_v2#list_entries" do
        {200, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)

        assert %{
                 catalog_entries: [
                   %{
                     aliases: ["lawrence@incident.io", "lawrence"],
                     archived_at: "2021-08-17T14:28:57.801578Z",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     name: "Primary On-call",
                     rank: 3,
                     updated_at: "2021-08-17T13:28:57.801578Z",
                     attribute_values: %{
                       abc123: %{
                         array_value: [
                           %{
                             catalog_entry: %{
                               archived_at: "2021-08-17T14:28:57.801578Z",
                               catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                               catalog_entry_name: "Primary escalation",
                               catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0"
                             },
                             helptext:
                               "Collection of standalone automations like auto-closing incidents.",
                             image_url:
                               "https://avatars.slack-edge.com/2021-08-09/2372763167857_6f65d94928b0a0ac590b_192.jpg",
                             is_image_slack_icon: false,
                             label: "Lawrence Jones",
                             literal: "SEV123",
                             reference: "incident.severity",
                             sort_key: "000020",
                             unavailable: false,
                             value: "abc123"
                           }
                         ],
                         value: %{
                           catalog_entry: %{
                             archived_at: "2021-08-17T14:28:57.801578Z",
                             catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             catalog_entry_name: "Primary escalation",
                             catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0"
                           },
                           helptext:
                             "Collection of standalone automations like auto-closing incidents.",
                           image_url:
                             "https://avatars.slack-edge.com/2021-08-09/2372763167857_6f65d94928b0a0ac590b_192.jpg",
                           is_image_slack_icon: false,
                           label: "Lawrence Jones",
                           literal: "SEV123",
                           reference: "incident.severity",
                           sort_key: "000020",
                           unavailable: false,
                           value: "abc123"
                         }
                       }
                     }
                   }
                 ],
                 catalog_type: %{
                   annotations: %{"incident.io/catalog-importer/id": "id-of-config"},
                   color: "yellow",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Represents Kubernetes clusters that we run inside of GKE.",
                   dynamic_resource_parameter: "abc123",
                   estimated_count: 7,
                   icon: "bolt",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   is_editable: false,
                   last_synced_at: "2021-08-17T13:28:57.801578Z",
                   name: "Kubernetes Cluster",
                   ranked: true,
                   registry_type: "PagerDutyService",
                   required_integrations: ["pager_duty"],
                   schema: %{
                     attributes: [
                       %{
                         array: false,
                         backlink_attribute: "abc123",
                         id: "01GW2G3V0S59R238FAHPDS1R66",
                         mode: "manual",
                         name: "tier",
                         type: "Custom[\"Service\"]"
                       }
                     ],
                     version: 1
                   },
                   semantic_type: "custom",
                   source_repo_url: "https://github.com/my-company/incident-io-catalog",
                   type_name: "Custom[\"BackstageGroup\"]",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 },
                 pagination_meta: %{after: "01FCNDV6P870EA6S7TK1DSYDG0", page_size: 25}
               } == response
      end
    end
  end

  describe "create/2" do
    @body %{
      aliases: [
        "lawrence@incident.io",
        "lawrence"
      ],
      attribute_values: %{
        abc123: %{
          array_value: [
            %{
              literal: "SEV123",
              reference: "incident.severity"
            }
          ],
          value: %{
            literal: "SEV123",
            reference: "incident.severity"
          }
        }
      },
      catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
      external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
      name: "Primary On-call",
      rank: 3
    }

    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#create_entry" do
        assert {201, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "catalog_v2#create_entry" do
        {201, response, _} =
          create(@client, @body)

        assert %{
                 catalog_entry: %{
                   aliases: ["lawrence@incident.io", "lawrence"],
                   archived_at: "2021-08-17T14:28:57.801578Z",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Primary On-call",
                   rank: 3,
                   updated_at: "2021-08-17T13:28:57.801578Z",
                   attribute_values: %{
                     abc123: %{
                       array_value: [
                         %{
                           catalog_entry: %{
                             archived_at: "2021-08-17T14:28:57.801578Z",
                             catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             catalog_entry_name: "Primary escalation",
                             catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0"
                           },
                           helptext:
                             "Collection of standalone automations like auto-closing incidents.",
                           image_url:
                             "https://avatars.slack-edge.com/2021-08-09/2372763167857_6f65d94928b0a0ac590b_192.jpg",
                           is_image_slack_icon: false,
                           label: "Lawrence Jones",
                           literal: "SEV123",
                           reference: "incident.severity",
                           sort_key: "000020",
                           unavailable: false,
                           value: "abc123"
                         }
                       ],
                       value: %{
                         catalog_entry: %{
                           archived_at: "2021-08-17T14:28:57.801578Z",
                           catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                           catalog_entry_name: "Primary escalation",
                           catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0"
                         },
                         helptext:
                           "Collection of standalone automations like auto-closing incidents.",
                         image_url:
                           "https://avatars.slack-edge.com/2021-08-09/2372763167857_6f65d94928b0a0ac590b_192.jpg",
                         is_image_slack_icon: false,
                         label: "Lawrence Jones",
                         literal: "SEV123",
                         reference: "incident.severity",
                         sort_key: "000020",
                         unavailable: false,
                         value: "abc123"
                       }
                     }
                   }
                 }
               } == response
      end
    end
  end

  describe "destroy/3" do
    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#destroy_entry" do
        assert {204, _, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "catalog_v2#destroy_entry" do
        assert {204, response, _} =
                 destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 catalog_entry: %{
                   aliases: ["lawrence@incident.io", "lawrence"],
                   archived_at: "2021-08-17T14:28:57.801578Z",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Primary On-call",
                   rank: 3,
                   updated_at: "2021-08-17T13:28:57.801578Z",
                   attribute_values: %{
                     abc123: %{
                       array_value: [
                         %{
                           catalog_entry: %{
                             archived_at: "2021-08-17T14:28:57.801578Z",
                             catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             catalog_entry_name: "Primary escalation",
                             catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0"
                           },
                           helptext:
                             "Collection of standalone automations like auto-closing incidents.",
                           image_url:
                             "https://avatars.slack-edge.com/2021-08-09/2372763167857_6f65d94928b0a0ac590b_192.jpg",
                           is_image_slack_icon: false,
                           label: "Lawrence Jones",
                           literal: "SEV123",
                           reference: "incident.severity",
                           sort_key: "000020",
                           unavailable: false,
                           value: "abc123"
                         }
                       ],
                       value: %{
                         catalog_entry: %{
                           archived_at: "2021-08-17T14:28:57.801578Z",
                           catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                           catalog_entry_name: "Primary escalation",
                           catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0"
                         },
                         helptext:
                           "Collection of standalone automations like auto-closing incidents.",
                         image_url:
                           "https://avatars.slack-edge.com/2021-08-09/2372763167857_6f65d94928b0a0ac590b_192.jpg",
                         is_image_slack_icon: false,
                         label: "Lawrence Jones",
                         literal: "SEV123",
                         reference: "incident.severity",
                         sort_key: "000020",
                         unavailable: false,
                         value: "abc123"
                       }
                     }
                   }
                 },
                 catalog_type: %{
                   annotations: %{"incident.io/catalog-importer/id": "id-of-config"},
                   color: "yellow",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Represents Kubernetes clusters that we run inside of GKE.",
                   dynamic_resource_parameter: "abc123",
                   estimated_count: 7,
                   icon: "bolt",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   is_editable: false,
                   last_synced_at: "2021-08-17T13:28:57.801578Z",
                   name: "Kubernetes Cluster",
                   ranked: true,
                   registry_type: "PagerDutyService",
                   required_integrations: ["pager_duty"],
                   schema: %{
                     attributes: [
                       %{
                         array: false,
                         backlink_attribute: "abc123",
                         id: "01GW2G3V0S59R238FAHPDS1R66",
                         mode: "manual",
                         name: "tier",
                         type: "Custom[\"Service\"]"
                       }
                     ],
                     version: 1
                   },
                   semantic_type: "custom",
                   source_repo_url: "https://github.com/my-company/incident-io-catalog",
                   type_name: "Custom[\"BackstageGroup\"]",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#show_entry" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "catalog_v2#show_entry" do
        assert {200, response, _} =
                 show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 catalog_entry: %{
                   aliases: ["lawrence@incident.io", "lawrence"],
                   archived_at: "2021-08-17T14:28:57.801578Z",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Primary On-call",
                   rank: 3,
                   updated_at: "2021-08-17T13:28:57.801578Z",
                   attribute_values: %{
                     abc123: %{
                       array_value: [
                         %{
                           catalog_entry: %{
                             archived_at: "2021-08-17T14:28:57.801578Z",
                             catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                             catalog_entry_name: "Primary escalation",
                             catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0"
                           },
                           helptext:
                             "Collection of standalone automations like auto-closing incidents.",
                           image_url:
                             "https://avatars.slack-edge.com/2021-08-09/2372763167857_6f65d94928b0a0ac590b_192.jpg",
                           is_image_slack_icon: false,
                           label: "Lawrence Jones",
                           literal: "SEV123",
                           reference: "incident.severity",
                           sort_key: "000020",
                           unavailable: false,
                           value: "abc123"
                         }
                       ],
                       value: %{
                         catalog_entry: %{
                           archived_at: "2021-08-17T14:28:57.801578Z",
                           catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                           catalog_entry_name: "Primary escalation",
                           catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0"
                         },
                         helptext:
                           "Collection of standalone automations like auto-closing incidents.",
                         image_url:
                           "https://avatars.slack-edge.com/2021-08-09/2372763167857_6f65d94928b0a0ac590b_192.jpg",
                         is_image_slack_icon: false,
                         label: "Lawrence Jones",
                         literal: "SEV123",
                         reference: "incident.severity",
                         sort_key: "000020",
                         unavailable: false,
                         value: "abc123"
                       }
                     }
                   }
                 },
                 catalog_type: %{
                   annotations: %{"incident.io/catalog-importer/id": "id-of-config"},
                   color: "yellow",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Represents Kubernetes clusters that we run inside of GKE.",
                   dynamic_resource_parameter: "abc123",
                   estimated_count: 7,
                   icon: "bolt",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   is_editable: false,
                   last_synced_at: "2021-08-17T13:28:57.801578Z",
                   name: "Kubernetes Cluster",
                   ranked: true,
                   registry_type: "PagerDutyService",
                   required_integrations: ["pager_duty"],
                   schema: %{
                     attributes: [
                       %{
                         array: false,
                         backlink_attribute: "abc123",
                         id: "01GW2G3V0S59R238FAHPDS1R66",
                         mode: "manual",
                         name: "tier",
                         type: "Custom[\"Service\"]"
                       }
                     ],
                     version: 1
                   },
                   semantic_type: "custom",
                   source_repo_url: "https://github.com/my-company/incident-io-catalog",
                   type_name: "Custom[\"BackstageGroup\"]",
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end

  describe "update/3" do
    @body %{
      aliases: [
        "lawrence@incident.io",
        "lawrence"
      ],
      attribute_values: %{
        abc123: %{
          array_value: [
            %{
              literal: "SEV123",
              reference: "incident.severity"
            }
          ],
          value: %{
            literal: "SEV123",
            reference: "incident.severity"
          }
        }
      },
      catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
      external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
      name: "Primary On-call",
      rank: 3
    }

    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#update_entry" do
        assert {200, _, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)
      end
    end

    test "returns expected response" do
      use_cassette "catalog_v2#update_entry" do
        assert {200, %{catalog_entry: catalog_entry, catalog_type: catalog_type}, _} =
                 update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)

        assert %{
                 aliases: [
                   "lawrence@incident.io",
                   "lawrence"
                 ],
                 archived_at: "2021-08-17T14:28:57.801578Z",
                 attribute_values: %{
                   abc123: %{
                     array_value: [
                       %{
                         catalog_entry: %{
                           archived_at: "2021-08-17T14:28:57.801578Z",
                           catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                           catalog_entry_name: "Primary escalation",
                           catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0"
                         },
                         helptext:
                           "Collection of standalone automations like auto-closing incidents.",
                         image_url:
                           "https://avatars.slack-edge.com/2021-08-09/2372763167857_6f65d94928b0a0ac590b_192.jpg",
                         is_image_slack_icon: false,
                         label: "Lawrence Jones",
                         literal: "SEV123",
                         reference: "incident.severity",
                         sort_key: "000020",
                         unavailable: false,
                         value: "abc123"
                       }
                     ],
                     value: %{
                       catalog_entry: %{
                         archived_at: "2021-08-17T14:28:57.801578Z",
                         catalog_entry_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         catalog_entry_name: "Primary escalation",
                         catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0"
                       },
                       helptext:
                         "Collection of standalone automations like auto-closing incidents.",
                       image_url:
                         "https://avatars.slack-edge.com/2021-08-09/2372763167857_6f65d94928b0a0ac590b_192.jpg",
                       is_image_slack_icon: false,
                       label: "Lawrence Jones",
                       literal: "SEV123",
                       reference: "incident.severity",
                       sort_key: "000020",
                       unavailable: false,
                       value: "abc123"
                     }
                   }
                 },
                 catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 created_at: "2021-08-17T13:28:57.801578Z",
                 external_id: "761722cd-d1d7-477b-ac7e-90f9e079dc33",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Primary On-call",
                 rank: 3,
                 updated_at: "2021-08-17T13:28:57.801578Z"
               } == catalog_entry

        assert %{
                 annotations: %{
                   "incident.io/catalog-importer/id": "id-of-config"
                 },
                 color: "yellow",
                 created_at: "2021-08-17T13:28:57.801578Z",
                 description: "Represents Kubernetes clusters that we run inside of GKE.",
                 dynamic_resource_parameter: "abc123",
                 estimated_count: 7,
                 icon: "bolt",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 is_editable: false,
                 last_synced_at: "2021-08-17T13:28:57.801578Z",
                 name: "Kubernetes Cluster",
                 ranked: true,
                 registry_type: "PagerDutyService",
                 required_integrations: [
                   "pager_duty"
                 ],
                 schema: %{
                   attributes: [
                     %{
                       array: false,
                       backlink_attribute: "abc123",
                       id: "01GW2G3V0S59R238FAHPDS1R66",
                       mode: "manual",
                       name: "tier",
                       type: "Custom[\"Service\"]"
                     }
                   ],
                   version: 1
                 },
                 semantic_type: "custom",
                 source_repo_url: "https://github.com/my-company/incident-io-catalog",
                 type_name: "Custom[\"BackstageGroup\"]",
                 updated_at: "2021-08-17T13:28:57.801578Z"
               } == catalog_type
      end
    end
  end
end
