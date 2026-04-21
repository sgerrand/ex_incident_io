defmodule IncidentIo.Response do
  @moduledoc false
  defstruct [:status, :headers, :body]
  @type t :: %__MODULE__{status: integer, headers: list, body: binary | nil}
end
