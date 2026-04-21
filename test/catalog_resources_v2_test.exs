defmodule IncidentIo.CatalogResourcesV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.CatalogResourcesV2

  doctest IncidentIo.CatalogResourcesV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/3" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
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
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected response" do
      {200, response, _} = list(@client)

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
             } == response
    end
  end
end
