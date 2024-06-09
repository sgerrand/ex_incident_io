defmodule IncidentIo.TestCase do
  @moduledoc """
  A wrapper for `ExUnit.Case` that configures ExVCR for mocking responses to
  HTTP requests.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
    end
  end
end
