defmodule IncidentIo.PostMortemsV2 do
  @moduledoc """
  Manage post-mortems for incidents.

  Post-mortems document lessons learned and follow-up actions after an incident
  is resolved. They help teams improve their processes and prevent recurrence.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  List all post-mortems for an organisation.

  Accepts optional pagination parameters:
  - `:after` - Cursor for pagination
  - `:page_size` - Number of items per page (default: 25, max: 250)

  ## Example

      IncidentIo.PostMortemsV2.list(client)

      IncidentIo.PostMortemsV2.list(client, page_size: 50)

  More information at: https://api-docs.incident.io/tag/Post-Mortems-V2#operation/Post%20Mortems%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  @spec list(Client.t(), keyword) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ []) do
    get("v2/post_mortems", client, opts)
  end

  @doc """
  Create a new post-mortem.

  ## Example

      IncidentIo.PostMortemsV2.create(client, %{
        incident_id: "01FCNDV6P870EA6S7TK1DSYDG0",
        name: "Incident post-mortem"
      })

  More information at: https://api-docs.incident.io/tag/Post-Mortems-V2#operation/Post%20Mortems%20V2_Create
  """
  @spec create(Client.t(), map()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post("v2/post_mortems", client, body)
  end

  @doc """
  Get a single post-mortem.

  ## Example

      IncidentIo.PostMortemsV2.show(client, "some-post-mortem-id")

  More information at: https://api-docs.incident.io/tag/Post-Mortems-V2#operation/Post%20Mortems%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get("v2/post_mortems/#{id}", client)
  end

  @doc """
  Update an existing post-mortem.

  ## Example

      IncidentIo.PostMortemsV2.update(client, "some-post-mortem-id", %{
        name: "Updated post-mortem"
      })

  More information at: https://api-docs.incident.io/tag/Post-Mortems-V2#operation/Post%20Mortems%20V2_Update
  """
  @spec update(Client.t(), binary, map()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put("v2/post_mortems/#{id}", client, body)
  end
end
