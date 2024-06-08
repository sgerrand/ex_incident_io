defmodule IncidentIo.CustomFieldOptionsV1 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @typep create_request_body :: %{
           optional(:sort_key) => integer,
           custom_field_id: binary,
           value: binary
         }
  @typep update_request_body :: %{
           sort_key: integer,
           value: binary
         }

  @doc """
  Show custom field options for a custom field.

  ## Example

      IncidentIo.CustomFieldOptionsV1.list(client, "some-custom-field-id")

      IncidentIo.CustomFieldOptionsV1.list(client, "some-custom-field-id", 10)

  More information at: https://api-docs.incident.io/tag/Custom-Field-Options-V1#operation/Custom%20Field%20Options%20V1_List
  """
  @spec list(Client.t(), binary) :: IncidentIo.response()
  @spec list(Client.t(), binary, integer) :: IncidentIo.response()
  def list(client \\ %Client{}, custom_field_id, page_size \\ 25) do
    get(
      "v1/custom_field_options",
      client,
      [
        custom_field_id: custom_field_id,
        page_size: page_size
      ]
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
  @spec create(Client.t(), create_request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v1/custom_field_options",
      client,
      body
    )
  end

  @doc """
  Delete a custom field option.

  ## Example

      IncidentIo.CustomFieldOptionsV1.destroy(client, "some-custom-field-option-id")

  More information at: https://api-docs.incident.io/tag/Custom-Field-Options-V1#operation/Custom%20Field%20Options%20V1_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete(
      "v1/custom_field_options/#{id}",
      client
    )
  end

  @doc """
  Get a single custom field option.

  ## Example

      IncidentIo.CustomFieldOptionsV1.show(client, "some-custom-field-option-id")

  More information at: https://api-docs.incident.io/tag/Custom-Field-Options-V1#operation/Custom%20Field%20Options%20V1_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v1/custom_field_options/#{id}",
      client
    )
  end

  @doc """
  Update a custom field option.

  Custom field option body example:
  ```elixir
  %{
    sort_key: 10,
    value: "Product"
  }
  ```

  ## Example

      IncidentIo.CustomFieldOptionsV1.update(client, "some-custom-field-option-id", body)

  More information at: https://api-docs.incident.io/tag/Custom-Field-Options-V1#operation/Custom%20Field%20Options%20V1_Update
  """
  @spec update(Client.t(), binary, update_request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put(
      "v1/custom_field_options/#{id}",
      client,
      body
    )
  end
end
