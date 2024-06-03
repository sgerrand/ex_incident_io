defmodule IncidentIoTest do
  use ExUnit.Case
  import IncidentIo
  alias Jason

  doctest IncidentIo

  setup_all do
    :meck.new(Jason, [:no_link])

    on_exit(fn ->
      :meck.unload(Jason)
    end)
  end

  setup do
    on_exit(fn ->
      Application.delete_env(:IncidentIo, :deserialization_options)
    end)
  end

  describe "authorization_header/2" do
    test "using JWT API key" do
      api_key =
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.EkN-DOsnsuRjRO6BxXemmJDm3HbxrbRzXglbN2S4sOkopdU4IsDxTI8jO19W_A4K8ZPJijNLis4EZsHeY559a4DFOd50_OqgHGuERTqYZyuhtF39yxJPAjUESwxk2J5k_4zM3O-vtd1Ghyo4IbqKKSy6J9mTniYJPenn5-HIirE"

      assert authorization_header(%{api_key: api_key}, []) == [
               {"Authorization", "Bearer #{api_key}"}
             ]
    end

    test "using JWT API key and additional headers" do
      api_key =
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.EkN-DOsnsuRjRO6BxXemmJDm3HbxrbRzXglbN2S4sOkopdU4IsDxTI8jO19W_A4K8ZPJijNLis4EZsHeY559a4DFOd50_OqgHGuERTqYZyuhtF39yxJPAjUESwxk2J5k_4zM3O-vtd1Ghyo4IbqKKSy6J9mTniYJPenn5-HIirE"

      header = {"Some-Other-Header", "defined here"}

      assert Enum.member?(
               authorization_header(%{api_key: api_key}, [header]),
               {"Authorization", "Bearer #{api_key}"}
             )

      assert Enum.member?(
               authorization_header(%{api_key: api_key}, [header]),
               {"Some-Other-Header", "defined here"}
             )
    end
  end

  describe "authorization_header/1" do
    test "using authentication credentials" do
      api_key = "someapikey"

      assert authorization_header(%{api_key: api_key}) == [
               {"User-agent", "IncidentIo/elixir"},
               {"Authorization", "Bearer #{api_key}"}
             ]
    end

    test "using unexpected input" do
      assert authorization_header({"Some", "List"}) == [
               {"User-agent", "IncidentIo/elixir"}
             ]
    end
  end

  test "process response on a 200 response" do
    assert {200, "json", _} =
             process_response(%HTTPoison.Response{status_code: 200, headers: %{}, body: "json"})

    assert :meck.validate(Jason)
  end

  test "process response on a non-200 response" do
    assert {404, "json", _} =
             process_response(%HTTPoison.Response{status_code: 404, headers: %{}, body: "json"})

    assert :meck.validate(Jason)
  end

  test "process_response_body with an empty body" do
    assert process_response_body("") == nil
  end

  test "process_response_body with content" do
    :meck.expect(Jason, :decode!, 2, :decoded_json)

    assert process_response_body("json") == :decoded_json
  end

  test "process_response_body with serialization options" do
    Application.put_env(:incident_io, :deserialization_options, keys: :atoms)

    :meck.expect(Jason, :decode!, fn _, [keys: :atoms] -> :decoded_json end)

    assert process_response_body("json") == :decoded_json
  end

  test "process response on a non-200 response and empty body" do
    assert {404, nil, _} =
             process_response(%HTTPoison.Response{status_code: 404, headers: %{}, body: nil})
  end
end

defmodule IncidentIo.JasonStringEncodingTest do
  use ExUnit.Case
  alias IncidentIo.JsonString

  test "nil encoded to empty string" do
    assert "" = Jason.encode!(%JsonString{body: nil})
  end

  test "empty string encoded to empty string" do
    assert "" = Jason.encode!(%JsonString{body: ""})
  end

  test "string encoded to JSON formatted string" do
    assert "\"some-string-of-text\"" = Jason.encode!(%JsonString{body: "some-string-of-text"})
  end
end
