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
end
