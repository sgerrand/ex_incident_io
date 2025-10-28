defmodule IncidentIo.TestCase do
  @moduledoc """
  A wrapper for `ExUnit.Case` that configures ExVCR for mocking responses to
  HTTP requests.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
      import Mox, only: [expect: 3, verify_on_exit!: 1]

      setup :verify_on_exit!
    end
  end
end
