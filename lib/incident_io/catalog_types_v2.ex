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

  @doc """
  Archives a catalog type and associated entries.

  ## Example

      IncidentIo.CatalogTypesV2.destroy(client, "some-catalog-type-id")

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_DestroyType
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete(
      "v2/catalog_types/#{id}",
      client
    )
  end

  @doc """
  Show a single catalog type.

  ## Example

      IncidentIo.CatalogTypesV2.show(client, "some-catalog-type-id")

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_ShowType
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v2/catalog_types/#{id}",
      client
    )
  end
end
