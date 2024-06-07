defmodule IncidentIo.CatalogTypesSchemaV2 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @typep mode :: [
           nil | :manual | :external | :internal | :dynamic | :backlink
         ]
  @typep request_body :: %{
          attributes: %{
            optional(:backlink_attribute) => binary,
            optional(:id) => binary,
            optional(:mode) => mode,
            array: bool,
            name: binary,
            type: binary
          },
          version: integer
        }

  @doc """
  Updates an existing catalog types schema, adding or removing attributes.

  Updating the schema is handled separately from creating and updating types, so
  that you don't have to worry about dependencies between types. For example, if
  type A has an attribute that relies on type B, you would have to create type B
  first.

  By allowing the creation of types without a schema, they can be created in any
  order, but it means that you need to make a separate call to this endpoint to
  update the schema.

  Catalog types schema body example:
  ```elixir
  %{
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
    "version": 1
  }
  ```

  ## Example

      IncidentIo.CatalogTypesV2.update(client, "some-catalog-type-schema-id", body)

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_UpdateTypeSchema
  """
  @spec update(Client.t(), binary, request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    post(
      "v2/catalog_types/#{id}/actions/update_schema",
      client,
      body
    )
  end
end
