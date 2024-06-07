defmodule IncidentIo.CustomFieldsV2 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @typep create_request_body :: %{
           description: binary,
           field_type: binary,
           name: binary
         }
  @typep update_request_body :: %{
           description: binary,
           name: binary
         }

  @doc """
  List all custom fields for an organisation.

  ## Example

      IncidentIo.CustomFieldsV2.list(client)

  More information at: https://api-docs.incident.io/tag/Custom-Fields-V2#operation/Custom%20Fields%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v2/custom_fields",
      client
    )
  end

  @doc """
  Create a new custom field.

  Custom field body example:
  ```elixir
  %{
    description: "Which team is impacted by this issue",
    field_type: "single_select",
    name: "Affected Team"
  }
  ```

  ## Example

      IncidentIo.CustomFieldsV2.create(client, body)

  More information at: https://api-docs.incident.io/tag/Custom-Fields-V2#operation/Custom%20Fields%20V2_Create
  """
  @spec create(Client.t(), create_request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v2/custom_fields",
      client,
      body
    )
  end

  @doc """
  Delete a custom field.

  ## Example

      IncidentIo.CustomFieldsV2.destroy(client, "some-custom-field-option-id")

  More information at: https://api-docs.incident.io/tag/Custom-Fields-V2#operation/Custom%20Fields%20V2_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete(
      "v2/custom_field_options/#{id}",
      client
    )
  end

  @doc """
  Get a single custom field.

  ## Example

      IncidentIo.CustomFieldsV2.show(client, "some-custom-field-option-id")

  More information at: https://api-docs.incident.io/tag/Custom-Fields-V2#operation/Custom%20Fields%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v2/custom_fields/#{id}",
      client
    )
  end

  @doc """
  Update the details of a custom field.

  Custom field body example:
  ```elixir
  %{
    description: "Which team is impacted by this issue",
    name: "Affected Team"
  }
  ```

  ## Example

      IncidentIo.CustomFieldsV2.update(client, "some-custom-field-option-id", body)

  More information at: https://api-docs.incident.io/tag/Custom-Fields-V2#operation/Custom%20Fields%20V2_Update
  """
  @spec update(Client.t(), binary, update_request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put(
      "v2/custom_fields/#{id}",
      client,
      body
    )
  end
end
