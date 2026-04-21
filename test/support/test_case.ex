defmodule IncidentIo.TestCase do
  @moduledoc """
  A wrapper for `ExUnit.Case` that configures Req.Test for mocking responses to
  HTTP requests.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import Mox, only: [expect: 3, verify_on_exit!: 1]

      setup :verify_on_exit!

      setup do
        Mox.stub(IncidentIo.Json.Mock, :decode!, fn body, opts -> Jason.decode!(body, opts) end)
        Mox.stub(IncidentIo.Json.Mock, :encode!, fn data, opts -> Jason.encode!(data, opts) end)
        :ok
      end
    end
  end
end
