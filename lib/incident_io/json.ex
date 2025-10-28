defmodule IncidentIo.Json do
  @moduledoc """
  Behaviour for JSON encoding/decoding operations.
  """

  @callback decode!(binary, keyword) :: term

  def decode!(body, opts \\ []) do
    impl().decode!(body, opts)
  end

  defp impl do
    Application.get_env(:incident_io, :json_module, Jason)
  end
end
