defmodule IncidentIo.UsersV2 do
  @moduledoc """
  View users.

  Users all have a single base role, and can be assigned multiple custom roles.
  They can be managed via your Slack workspace or SAML provider.
  """

  import IncidentIo
  alias IncidentIo.Client

  @typep page_filters :: [
           after: nonempty_binary,
           page_size: pos_integer()
         ]
  @typep user_filters :: [
           email: nonempty_binary,
           slack_user_id: nonempty_binary
         ]
  @typep request_options :: page_filters() | user_filters()

  @doc """
  List users for an organisation.

  ## Example

      IncidentIo.UsersV2.list(client)

      IncidentIo.UsersV2.list(client, email: "some-user@your-company.tld")

  More information at: https://api-docs.incident.io/tag/Users-V2#operation/Users%20V2_List
  """
  @spec list(Client.t(), request_options()) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ []) do
    get(
      "v2/users",
      client,
      opts
    )
  end

  @doc """
  Get a single user.

  ## Example

      IncidentIo.UsersV2.show(client, "some-user-id")

  More information at: https://api-docs.incident.io/tag/Users-V2#operation/Users%20V2_Show
  """
  @spec show(Client.t(), nonempty_binary()) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v2/users/#{id}",
      client
    )
  end
end
