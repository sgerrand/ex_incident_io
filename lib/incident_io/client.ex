defmodule IncidentIo.Client do
  @moduledoc """
  Creates a HTTP client for interacting with the Incident.io API.
  """

  defstruct auth: nil, endpoint: "https://api.incident.io/"

  @type auth :: %{api_key: binary}
  @type deprecated_incident_modes :: [:real | :test | :tutorial]
  @type incident_modes :: [:standard | :retrospective | :test | :tutorial | :stream]
  @type t :: %__MODULE__{auth: auth | nil, endpoint: binary}

  @spec new() :: t
  def new(), do: %__MODULE__{}

  @spec new(binary) :: t
  def new(endpoint) when is_binary(endpoint) do
    pnew(nil, endpoint)
  end

  @spec new(map()) :: t
  def new(auth = %{api_key: _}), do: %__MODULE__{auth: auth}

  @spec new(map(), binary) :: t
  def new(auth = %{api_key: _}, endpoint) do
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
