defmodule IncidentIo.CustomFieldOptionsV1 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @doc """
  Show custom field options for a custom field.

  ## Example

      IncidentIo.CustomFieldOptionsV1.list(client, "come-custom-field-id")

  More information at: https://api-docs.incident.io/tag/Custom-Field-Options-V1#operation/Custom%20Field%20Options%20V1_List
  """
  @spec list(Client.t(), binary) :: IncidentIo.response()
  @spec list(Client.t(), binary, integer) :: IncidentIo.response()
  def list(client \\ %Client{}, custom_field_id, page_size \\ 25) do
    get(
      "v2/custom_field_options",
      client,
      %{
        custom_field_id: custom_field_id,
        page_size: page_size
      }
    )
  end
end
