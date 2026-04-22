defmodule IncidentIo.Client do
  @moduledoc """
  Creates a HTTP client for interacting with the Incident.io API.
  """

  defstruct auth: nil, endpoint: "https://api.incident.io/"

  @type auth :: %{api_key: binary}
  @type t :: %__MODULE__{auth: auth | nil, endpoint: binary}

  @doc """
  Creates a client with no authentication and the default endpoint.

  ## Example

      IncidentIo.Client.new()
  """
  @spec new() :: t
  def new, do: %__MODULE__{}

  @doc """
  Creates a client with a custom endpoint and no authentication.

  The endpoint must be a binary URL. A trailing `/` is appended automatically
  if not present.

  ## Example

      IncidentIo.Client.new("https://api.example.com/")
  """
  @spec new(binary) :: t
  def new(endpoint) when is_binary(endpoint) do
    pnew(nil, endpoint)
  end

  @doc """
  Creates a client with API key authentication and the default endpoint.

  ## Example

      IncidentIo.Client.new(%{api_key: "your-api-key"})
  """
  @spec new(map()) :: t
  def new(%{api_key: _} = auth), do: %__MODULE__{auth: auth}

  @doc """
  Creates a client with API key authentication and a custom endpoint.

  The endpoint must be a binary URL. A trailing `/` is appended automatically
  if not present.

  ## Example

      IncidentIo.Client.new(%{api_key: "your-api-key"}, "https://api.example.com/")
  """
  @spec new(map(), binary) :: t
  def new(%{api_key: _} = auth, endpoint) do
    pnew(auth, endpoint)
  end

  @spec new(auth, binary) :: t
  defp pnew(auth, endpoint) do
    endpoint =
      if String.ends_with?(endpoint, "/") do
        endpoint
      else
        endpoint <> "/"
      end

    %__MODULE__{auth: auth, endpoint: endpoint}
  end
end
