defmodule IncidentIo.CatalogTypesV2 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List entries for a catalog type.

  ## Example

      IncidentIo.CatalogTypesV2.list(client)

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_ListTypes
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v2/catalog_types",
      client
    )
  end
end
