defmodule IncidentIo.CatalogV2Test do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import IncidentIo.CatalogV2

  doctest IncidentIo.CatalogV2

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list_entries/3" do
    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#list_entries" do
        assert {200, _, _} = list_entries(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)
      end
    end

    test "returns expected number of catalog_entries" do
      use_cassette "catalog_v2#list_entries" do
        {200, %{catalog_entries: catalog_entries}, _} =
          list_entries(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)

        assert Enum.count(catalog_entries) == 1
      end
    end

    test "returns expected attributes for catalog_entry" do
      use_cassette "catalog_v2#list_entries" do
        {200,
         %{
           catalog_entries: [
             %{
               aliases: aliases,
               archived_at: archived_at,
               created_at: created_at,
               catalog_type_id: catalog_type_id,
               external_id: external_id,
               id: id,
               name: name,
               rank: rank,
               updated_at: updated_at
             }
           ]
         }, _} = list_entries(@client, "01FCNDV6P870EA6S7TK1DSYDG0", true)

        assert aliases == ["lawrence@incident.io", "lawrence"]
        assert archived_at == "2021-08-17T14:28:57.801578Z"
        assert created_at == "2021-08-17T13:28:57.801578Z"
        assert catalog_type_id == "01FCNDV6P870EA6S7TK1DSYDG0"
        assert external_id == "761722cd-d1d7-477b-ac7e-90f9e079dc33"
        assert id == "01FCNDV6P870EA6S7TK1DSYDG0"
        assert name == "Primary On-call"
        assert rank == 3
        assert updated_at == "2021-08-17T13:28:57.801578Z"
      end
    end

    test "returns expected attributes for catalog_type" do
      use_cassette "catalog_v2#list_entries" do
        {200,
         %{
           catalog_type: %{
             annotations: annotations,
             color: color,
             created_at: created_at,
             description: description,
             dynamic_resource_parameter: dynamic_resource_parameter,
             estimated_count: estimated_count,
             icon: icon,
             id: id,
             is_editable: is_editable,
             last_synced_at: last_synced_at,
             name: name,
             ranked: ranked,
             registry_type: registry_type,
             required_integrations: required_integrations,
             schema: schema,
             semantic_type: semantic_type,
             source_repo_url: source_repo_url,
             type_name: type_name,
             updated_at: updated_at
           }
         }, _} = list_entries(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert annotations == %{"incident.io/catalog-importer/id": "id-of-config"}
        assert color == "yellow"
        assert created_at == "2021-08-17T13:28:57.801578Z"
        assert description == "Represents Kubernetes clusters that we run inside of GKE."
        assert dynamic_resource_parameter == "abc123"
        assert estimated_count == 7
        assert icon == "bolt"
        assert id == "01FCNDV6P870EA6S7TK1DSYDG0"
        assert is_editable == false
        assert last_synced_at == "2021-08-17T13:28:57.801578Z"
        assert name == "Kubernetes Cluster"
        assert ranked == true
        assert registry_type == "PagerDutyService"
        assert required_integrations == ["pager_duty"]

        assert schema == %{
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

        assert semantic_type == "custom"
        assert source_repo_url == "https://github.com/my-company/incident-io-catalog"
        assert type_name == "Custom[\"BackstageGroup\"]"
        assert updated_at == "2021-08-17T13:28:57.801578Z"
      end
    end
  end
end