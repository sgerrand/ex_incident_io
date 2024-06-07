defmodule IncidentIo.CatalogTypesSchemaV2Test do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import IncidentIo.CatalogTypesSchemaV2

  doctest IncidentIo.CatalogTypesSchemaV2

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "update/3" do
    @body %{
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
    }

    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#update_type_schema" do
        assert {200, _, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)
      end
    end

    test "returns expected response" do
      use_cassette "catalog_v2#update_type_schema" do
        assert {200, catalog_type, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)

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
