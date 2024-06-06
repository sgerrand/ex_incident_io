defmodule IncidentIo.CatalogTypesV2 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client
  alias IncidentIo.Icon

  @type request_body :: %{
          optional(:annotations) => %{
            binary => binary
          },
          optional(:color) => binary,
          optional(:icon) => Icon.t(),
          optional(:ranked) => binary,
          optional(:source_repo_url) => binary,
          optional(:type_name) => binary,
          description: binary,
          name: binary
        }

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

  @doc """
  Create a catalog type.

  ## Example

      IncidentIo.CatalogTypesV2.create(client)

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_CreateType
  """
  @spec create(Client.t(), CatalogTypesV2.request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v2/catalog_types",
      client,
      body
    )
  end
end
