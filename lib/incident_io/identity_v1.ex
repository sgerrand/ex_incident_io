defmodule IncidentIo.IdentityV1 do
  @moduledoc """
  Test if your API key is valid, and which roles it has.
  """

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  Get the identity associated with the API key used for the request.

  ## Example

      IncidentIo.IdentityV1.show(client)

  More information at: https://api-docs.incident.io/tag/Utilities-V1#operation/Utilities%20V1_Identity
  """
  @spec show(Client.t()) :: IncidentIo.response()
  def show(client \\ %Client{}) do
    get(
      "v1/identity",
      client
    )
  end
end
