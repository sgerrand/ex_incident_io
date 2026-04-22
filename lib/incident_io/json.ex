defmodule IncidentIo.Json do
  @moduledoc """
  Behaviour for JSON encoding/decoding operations.

  The JSON backend defaults to `Jason` but is swappable via application config,
  which is useful in tests when you want to use a mock:

      # config/test.exs
      config :incident_io, :json_module, IncidentIo.Json.Mock

  Any replacement module must implement the `decode!/2` and `encode!/2`
  callbacks defined by this behaviour.
  """

  @callback decode!(binary, keyword) :: term
  @callback encode!(term, keyword) :: binary

  @doc """
  Decodes a JSON binary into an Elixir term.

  Delegates to the configured JSON module (default: `Jason`).

  ## Example

      IncidentIo.Json.decode!("{\"key\": \"value\"}")
      #=> %{"key" => "value"}
  """
  def decode!(body, opts \\ []) do
    impl().decode!(body, opts)
  end

  @doc """
  Encodes an Elixir term into a JSON binary.

  Delegates to the configured JSON module (default: `Jason`).

  ## Example

      IncidentIo.Json.encode!(%{key: "value"})
      #=> "{\"key\":\"value\"}"
  """
  def encode!(data, opts \\ []) do
    impl().encode!(data, opts)
  end

  defp impl do
    Application.get_env(:incident_io, :json_module, Jason)
  end
end
