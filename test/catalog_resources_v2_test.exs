defmodule IncidentIo.CatalogResourcesV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.CatalogResourcesV2

  doctest IncidentIo.CatalogResourcesV2

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/3" do
    test "returns expected HTTP status code" do
      use_cassette "catalog_v2#list_resources" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "catalog_v2#list_resources" do
        {200, resources, _} = list(@client)

        assert %{
                 resources: [
                   %{
                     category: "custom",
                     description: "Boolean true or false value",
                     label: "GitHub Repository",
                     type: "CatalogEntry[\"01GVGYJSD39FRKVDWACK9NDS4E\"]",
                     value_docstring:
                       "Either the GraphQL node ID of the repository or a string of <owner>/<repo>, e.g. incident-io/website"
                   }
                 ]
               } == resources
      end
    end
  end
end
