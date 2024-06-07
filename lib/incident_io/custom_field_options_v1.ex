defmodule IncidentIo.CustomFieldOptionsV1 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @typep request_body :: %{
           optional(:sort_key) => integer,
           custom_field_id: binary,
           value: binary
         }

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

  @doc """
  Create a custom field option.

  Custom field option body example:
  ```elixir
  %{
    custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
    sort_key: 10,
    value: "Product"
  }
  ```

  ## Example

      IncidentIo.CustomFieldOptionsV1.create(client, body)

  More information at: https://api-docs.incident.io/tag/Custom-Field-Options-V1#operation/Custom%20Field%20Options%20V1_Create
  """
  @spec create(Client.t(), request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v2/custom_field_options",
      client,
      body
    )
  end
end
