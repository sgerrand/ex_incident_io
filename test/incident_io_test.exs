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

  test "authorization_header using JWT API key" do
    api_key =
      "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.EkN-DOsnsuRjRO6BxXemmJDm3HbxrbRzXglbN2S4sOkopdU4IsDxTI8jO19W_A4K8ZPJijNLis4EZsHeY559a4DFOd50_OqgHGuERTqYZyuhtF39yxJPAjUESwxk2J5k_4zM3O-vtd1Ghyo4IbqKKSy6J9mTniYJPenn5-HIirE"

    assert authorization_header(%{api_key: api_key}, []) == [{"Authorization", "Bearer #{api_key}"}]
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
