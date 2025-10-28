defmodule IncidentIo.JsonTest do
  use IncidentIo.TestCase, async: true

  alias IncidentIo.Json

  setup do
    on_exit(fn ->
      Application.delete_env(:incident_io, :json_module)
    end)
  end

  describe "decode!/2" do
    test "decodes JSON with default implementation (Jason)" do
      json_string = ~s({"key": "value", "number": 42})

      result = Json.decode!(json_string)

      assert result == %{"key" => "value", "number" => 42}
    end

    test "decodes JSON with options using default implementation" do
      Application.put_env(:incident_io, :json_module, Jason)
      json_string = ~s({"key": "value"})

      result = Json.decode!(json_string, keys: :atoms)

      assert result == %{key: "value"}
    end

    test "uses custom implementation when configured" do
      IncidentIo.Json.Mock
      |> expect(:decode!, fn json, opts -> {:custom, json, opts} end)

      Application.put_env(:incident_io, :json_module, IncidentIo.Json.Mock)

      result = Json.decode!(~s({"test": true}), keys: :atoms)

      assert result == {:custom, ~s({"test": true}), keys: :atoms}
    end
  end

  describe "encode!/2" do
    test "encodes data with default implementation (Jason)" do
      data = %{"key" => "value", "number" => 42}

      result = Json.encode!(data)

      assert Jason.decode!(result) == data
    end

    test "encodes data with options using default implementation" do
      Application.put_env(:incident_io, :json_module, Jason)
      data = %{key: "value"}

      result = Json.encode!(data, pretty: true)

      assert String.contains?(result, "\n")
      assert Jason.decode!(result) == %{"key" => "value"}
    end

    test "uses custom implementation when configured" do
      IncidentIo.Json.Mock
      |> expect(:encode!, fn data, opts -> {:custom_encoded, data, opts} end)

      Application.put_env(:incident_io, :json_module, IncidentIo.Json.Mock)

      result = Json.encode!(%{test: true}, pretty: true)

      assert result == {:custom_encoded, %{test: true}, pretty: true}
    end
  end

  describe "implementation configuration" do
    test "defaults to Jason when no configuration is set" do
      Application.delete_env(:incident_io, :json_module)

      result = Json.decode!(~s({"default": true}))

      assert result == %{"default" => true}
    end
  end

  describe "error handling" do
    test "propagates Jason decode errors" do
      Application.put_env(:incident_io, :json_module, Jason)

      assert_raise Jason.DecodeError, fn ->
        Json.decode!("invalid json")
      end
    end

    test "propagates Jason encode errors" do
      Application.put_env(:incident_io, :json_module, Jason)

      assert_raise Protocol.UndefinedError, fn ->
        Json.encode!(fn -> "cannot encode functions" end)
      end
    end

    test "propagates custom implementation errors" do
      IncidentIo.Json.Mock
      |> expect(:decode!, fn _, _ -> raise "Custom error" end)

      Application.put_env(:incident_io, :json_module, IncidentIo.Json.Mock)

      assert_raise RuntimeError, "Custom error", fn ->
        Json.decode!("any string")
      end
    end
  end
end
