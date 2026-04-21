defmodule IncidentIo.CatalogResourcesV2 do
  @moduledoc """
  List available catalog resources.

  Catalog resources are the external resource types (e.g. PagerDuty services,
  GitHub repositories) that can be referenced as attribute values in catalog
  entries.
  """

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
