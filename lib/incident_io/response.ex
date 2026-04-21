defmodule IncidentIo.Response do
  @moduledoc """
  Represents an HTTP response returned by the Incident.io API client.
  """
  defstruct [:status, :headers, :body]
  @type t :: %__MODULE__{status: integer, headers: list, body: binary | nil}
end
