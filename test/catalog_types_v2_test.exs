defmodule IncidentIo.CatalogTypesV2Test do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import IncidentIo.CatalogTypesV2

  doctest IncidentIo.CatalogTypesV2

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#list_types" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "catalog_v2#list_types" do
        {200, catalog_types, _} = list(@client)

        assert %{
                 catalog_types: [
                   %{
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
                   }
                 ]
               } == catalog_types
      end
    end
  end

  describe "create/2" do
    @body %{
      annotations: %{
        "incident.io/catalog-importer/id": "id-of-config"
      },
      color: "yellow",
      description: "Represents Kubernetes clusters that we run inside of GKE.",
      icon: "bolt",
      name: "Kubernetes Cluster",
      ranked: true,
      source_repo_url: "https://github.com/my-company/incident-io-catalog",
      type_name: "Custom[\"BackstageGroup\"]"
    }

    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#create_type" do
        assert {201, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "catalog_v2#create_type" do
        assert {201, catalog_type, _} = create(@client, @body)

        assert %{
                 catalog_type: %{
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
                 }
               } == catalog_type
      end
    end
  end

  describe "destroy/2" do
    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#destroy_type" do
        assert {204, _, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "catalog_v2#destroy_type" do
        assert {204, catalog_type, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 catalog_type: %{
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
                 }
               } == catalog_type
      end
    end
  end
end
