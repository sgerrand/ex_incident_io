defmodule IncidentIo.CatalogV2 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @type body :: %{
          optional(:catalog_type_id) => binary,
          aliases: list,
          attribute_values: %{
            binary => %{
              array_value: [engine_param_binding, ...],
              value: engine_param_binding
            }
          },
          external_id: binary,
          name: binary,
          rank: integer
        }
  @type engine_param_binding :: %{
          literal: binary,
          reference: binary
        }

  @doc """
  List entries for a catalog type.

  ## Example

      IncidentIo.CatalogV2.list_entries(client, "some-catalog-type-id")

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_ListEntries
  """
  @spec list_entries(Client.t(), binary) :: IncidentIo.response()
  @spec list_entries(Client.t(), binary, integer) :: IncidentIo.response()
  def list_entries(client \\ %Client{}, catalog_type_id, page_size \\ 25) do
    get(
      "v2/catalog_entries",
      client,
      %{
        catalog_type_id: catalog_type_id,
        page_size: page_size
      }
    )
  end

  @doc """
  Create an entry within the catalog.

  Catalog entry body example:
  ```elixir
  %{
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
  ```

  ## Example

      IncidentIo.CatalogV2.create_entry(client, "some-catalog-type-id", body)

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_CreateEntry
  """
  @spec create_entry(Client.t(), binary, CatalogV2.body()) :: IncidentIo.response()
  def create_entry(client \\ %Client{}, catalog_type_id, body) do
    if valid_entry?(body, catalog_type_id) do
      post(
        "v2/catalog_entries",
        client,
        body
      )
    end
  end

  @doc """
  Archives a catalog entry.

  ## Example

      IncidentIo.CatalogV2.destroy_entry(client, "some-catalog-entry-id")

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_DestroyEntry
  """
  @spec destroy_entry(Client.t(), binary) :: IncidentIo.response()
  def destroy_entry(client \\ %Client{}, id) do
    delete(
      "v2/catalog_entries/#{id}",
      client
    )
  end

  @doc """
  Show a single catalog entry.

  ## Example

      IncidentIo.CatalogV2.show_entry(client, "some-catalog-entry-id")

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_ShowEntry
  """
  @spec show_entry(Client.t(), binary) :: IncidentIo.response()
  def show_entry(client \\ %Client{}, id) do
    get(
      "v2/catalog_entries/#{id}",
      client
    )
  end

  @doc """
  Updates an existing catalog entry.

  Catalog entry body example:
  ```elixir
  %{
    aliases: [
      "not lawrence"
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
    name: "Was Primary On-call",
    rank: 5
  }
  ```
  ## Example

      IncidentIo.CatalogV2.update_entry(client, "some-catalog-entry-id", body)

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_UpdateEntry
  """
  @spec update_entry(Client.t(), binary, CatalogV2.body()) :: IncidentIo.response()
  def update_entry(client \\ %Client{}, id, body) do
    put(
      "v2/catalog_entries/#{id}",
      client,
      body
    )
  end

  defp valid_entry?(body, catalog_type_id), do: body.catalog_type_id == catalog_type_id
end
