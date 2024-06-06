defmodule IncidentIo.CatalogResourcesV2 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List entries for a catalog type.

  ## Example

      IncidentIo.CatalogResourcesV2.list(client)

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_ListResources
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v2/catalog_resources",
      client
    )
  end
end
