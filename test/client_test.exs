defmodule IncidentIo.ClientTest do
  use ExUnit.Case
  import IncidentIo.Client

  doctest IncidentIo.Client

  test "default endpoint" do
    client = new()
    assert client.endpoint == "https://api.incident.io/"
  end

  test "custom endpoint" do
    expected = "https://inc.foo.com/api/v3/"

    creds = %{api_token: "some-JWT-token"}

    client = new(creds, "https://inc.foo.com/api/v3/")
    assert client.endpoint == expected

    client = new("https://inc.foo.com/api/v3/")
    assert client.endpoint == expected

    # when tailing '/' is missing
    client = new(creds, "https://inc.foo.com/api/v3")
    assert client.endpoint == expected
  end
end
