defmodule IncidentIo.CustomFieldsV1 do
  @moduledoc false

  import IncidentIo
  alias IncidentIo.Client

  @typep create_request_body :: %{
           description: binary,
           field_type: binary,
           name: binary,
           required: binary,
           required_v2: binary,
           show_before_closure: bool,
           show_before_creation: bool,
           show_before_update: bool,
           show_in_announcement_post: bool
         }
  @typep update_request_body :: %{
           optional(:required) => binary,
           optional(:required_v2) => binary,
           optional(:show_in_announcement_post) => bool,
           description: binary,
           field_type: binary,
           name: binary,
           show_before_closure: bool,
           show_before_creation: bool,
           show_before_update: bool
         }

  @doc """
  List all custom fields for an organisation.

  ## Example

      IncidentIo.CustomFieldsV1.list(client)

  More information at: https://api-docs.incident.io/tag/Custom-Fields-V1#operation/Custom%20Fields%20V1_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v1/custom_fields",
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
    name: "Affected Team",
    required: "never",
    required_v2: "never",
    show_before_closure: true,
    show_before_creation: true,
    show_before_update: true,
    show_in_announcement_post: true
  }
  ```

  ## Example

      IncidentIo.CustomFieldsV1.create(client, body)

  More information at: https://api-docs.incident.io/tag/Custom-Fields-V1#operation/Custom%20Fields%20V1_Create
  """
  @spec create(Client.t(), create_request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v1/custom_fields",
      client,
      body
    )
  end

  @doc """
  Delete a custom field.

  ## Example

      IncidentIo.CustomFieldsV1.destroy(client, "some-custom-field-option-id")

  More information at: https://api-docs.incident.io/tag/Custom-Fields-V1#operation/Custom%20Fields%20V1_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete(
      "v1/custom_field_options/#{id}",
      client
    )
  end

  @doc """
  Get a single custom field.

  ## Example

      IncidentIo.CustomFieldsV1.show(client, "some-custom-field-option-id")

  More information at: https://api-docs.incident.io/tag/Custom-Fields-V1#operation/Custom%20Fields%20V1_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v1/custom_field_options/#{id}",
      client
    )
  end

  @doc """
  Update the details of a custom field.

  Custom field body example:
  ```elixir
  %{
    description: "Which team is impacted by this issue",
    field_type: "single_select",
    name: "Affected Team",
    required: "never",
    required_v2: "never",
    show_before_closure: true,
    show_before_creation: true,
    show_before_update: true,
    show_in_announcement_post: true
  }
  ```

  ## Example

      IncidentIo.CustomFieldsV1.update(client, "some-custom-field-option-id", body)

  More information at: https://api-docs.incident.io/tag/Custom-Fields-V1#operation/Custom%20Fields%20V1_Update
  """
  @spec update(Client.t(), binary, update_request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put(
      "v1/custom_fields/#{id}",
      client,
      body
    )
  end
end
