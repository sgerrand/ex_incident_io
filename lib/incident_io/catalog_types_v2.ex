defmodule IncidentIo.CatalogTypesV2 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @typep color :: [
           :yellow | :green | :blue | :violet | :pink | :cyan | :orange
         ]
  @typep icon :: [
           :bolt
           | :box
           | :briefcase
           | :browser
           | :bulb
           | :calendar
           | :clock
           | :cog
           | :components
           | :database
           | :doc
           | :email
           | :files
           | :flag
           | :folder
           | :globe
           | :money
           | :server
           | :severity
           | :store
           | :star
           | :tag
           | :user
           | :users
         ]
  @type request_body :: %{
          optional(:annotations) => %{
            binary => binary
          },
          optional(:color) => color(),
          optional(:icon) => icon(),
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

  Catalog type body example:
  ```elixir
  %{
      annotations: %{
        "incident.io/catalog-importer/id": "id-of-config"
      },
      color: "yellow",
      description: "Represents Kubernetes clusters that we run inside of GKE.",
      icon: "bolt",
      name: "Kubernetes Cluster",
      ranked: true,
      source_repo_url: "https://github.com/my-company/incident-io-catalog",
      type_name: "Custom[\"BackstageGroup\"]"
  }
  ```

  ## Example

      IncidentIo.CatalogTypesV2.create(client, body)

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

  @doc """
  Updates an existing catalog type.

  Catalog type body example:
  ```elixir
  %{
      annotations: %{
        "incident.io/catalog-importer/id": "id-of-config"
      },
      color: "yellow",
      description: "Represents Kubernetes clusters that we run inside of GKE.",
      icon: "bolt",
      name: "Kubernetes Cluster",
      ranked: true,
      source_repo_url: "https://github.com/my-company/incident-io-catalog"
  }
  ```

  ## Example

      IncidentIo.CatalogTypesV2.update(client, "some-catalog-type-id", body)

  More information at: https://api-docs.incident.io/tag/Catalog-V2#operation/Catalog%20V2_UpdateType
  """
  @spec update(Client.t(), binary, CatalogTypesV2.request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put(
      "v2/catalog_types/#{id}",
      client,
      body
    )
  end
end
