defmodule IncidentIo.CatalogV2 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

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
end
