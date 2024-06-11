defmodule IncidentIo.QueryTest do
  # taken from https://github.com/elixir-plug/plug/blob/v1.16.0/test/plug/conn/query_test.exs
  use IncidentIo.TestCase, async: true

  import IncidentIo.Query, only: [decode: 1, encode: 1, encode: 2]
  doctest IncidentIo.Query

  describe "decode" do
    test "queries" do
      params = decode("foo=bar&baz=bat")
      assert params["foo"] == "bar"
      assert params["baz"] == "bat"

      params = decode("users[name]=hello&users[age]=17&users[address][street]=foo")
      assert params["users"]["name"] == "hello"
      assert params["users"]["age"] == "17"
      assert params["users"]["address"] == %{"street" => "foo"}

      params = decode("my+weird+field=q1%212%22%27w%245%267%2Fz8%29%3F")
      assert params["my weird field"] == "q1!2\"'w$5&7/z8)?"

      assert decode("=")[""] == ""
      assert decode("key")["key"] == ""
      assert decode("key=")["key"] == ""
      assert decode("=value")[""] == "value"

      assert decode("foo[]")["foo"] == [""]
      assert decode("foo[]=")["foo"] == [""]
      assert decode("foo[]=bar&foo[]=baz")["foo"] == ["bar", "baz"]
      assert decode("foo[]=bar&foo[]=baz")["foo"] == ["bar", "baz"]

      params = decode("foo[]=bar&foo[]=baz&bat[]=1&bat[]=2")
      assert params["foo"] == ["bar", "baz"]
      assert params["bat"] == ["1", "2"]

      assert decode("x[y][z]=1")["x"]["y"]["z"] == "1"
      assert decode("x[y][z][]=1")["x"]["y"]["z"] == ["1"]
      assert decode("x[y][z]=1&x[y][z]=2")["x"]["y"]["z"] == "2"
      assert decode("x[y][z][]=1&x[y][z][]=2")["x"]["y"]["z"] == ["1", "2"]

      assert Enum.at(decode("x[y][][z]=1")["x"]["y"], 0)["z"] == "1"
      assert Enum.at(decode("x[y][][z][]=1")["x"]["y"], 0)["z"] |> Enum.at(0) == "1"
    end

    test "nested lists" do
      assert decode("x[][][]=1") == %{"x" => [[["1"]]]}
    end

    test "empty pairs" do
      assert decode("&x=1&&y=2&") == %{"x" => "1", "y" => "2"}
    end

    test "last always wins on bad queries" do
      assert decode("x[]=1&x[y]=1")["x"]["y"] == "1"
      assert decode("x[y][][w]=2&x[y]=1")["x"]["y"] == "1"
      assert decode("x=1&x[y]=1")["x"]["y"] == "1"
      assert decode("x[y][0][w]=2&x[y]=1")["x"]["y"] == "1"
    end
  end

  describe "encode" do
    test "data" do
      assert encode(%{foo: "bar", baz: "bat"}) in ["baz=bat&foo=bar", "foo=bar&baz=bat"]

      assert encode(%{foo: nil}) == "foo="
      assert encode(%{foo: "bå®"}) == "foo=b%C3%A5%C2%AE"
      assert encode(%{foo: 1337}) == "foo=1337"
      assert encode(%{foo: ["bar", "baz"]}) == "foo[]=bar&foo[]=baz"

      assert encode(%{users: %{name: "hello", age: 17}}) in [
               "users[name]=hello&users[age]=17",
               "users[age]=17&users[name]=hello"
             ]

      assert encode(%{users: [name: "hello", age: 17]}) == "users[name]=hello&users[age]=17"

      assert encode(%{users: [name: "hello", age: 17, name: "goodbye"]}) ==
               "users[name]=hello&users[age]=17"

      assert encode(%{"my weird field": "q1!2\"'w$5&7/z8)?"}) ==
               "my+weird+field=q1%212%22%27w%245%267%2Fz8%29%3F"

      assert encode(%{foo: %{"my weird field": "q1!2\"'w$5&7/z8)?"}}) ==
               "foo[my+weird+field]=q1%212%22%27w%245%267%2Fz8%29%3F"

      assert encode(%{}) == ""
      assert encode([]) == ""

      assert encode(%{foo: [""]}) == "foo[]="

      assert encode(%{foo: ["bar", "baz"], bat: [1, 2]}) in [
               "bat[]=1&bat[]=2&foo[]=bar&foo[]=baz",
               "foo[]=bar&foo[]=baz&bat[]=1&bat[]=2"
             ]

      assert encode(%{x: %{y: %{z: 1}}}) == "x[y][z]=1"
      assert encode(%{x: %{y: %{z: [1]}}}) == "x[y][z][]=1"
      assert encode(%{x: %{y: %{z: [1, 2]}}}) == "x[y][z][]=1&x[y][z][]=2"
      assert encode(%{x: %{y: [%{z: 1}]}}) == "x[y][][z]=1"
      assert encode(%{x: %{y: [%{z: [1]}]}}) == "x[y][][z][]=1"
    end

    test "nested lists" do
      assert encode(%{"x" => [[[1]]]}) == "x[][][]=1"
    end

    test "with custom encoder" do
      encoder = &(&1 |> to_string |> String.duplicate(2))

      assert encode([foo: "bar", baz: "bat"], encoder) == "foo=barbar&baz=batbat"
      assert encode([foo: ["bar", "baz"]], encoder) == "foo[]=barbar&foo[]=bazbaz"
      assert encode([foo: URI.parse("/bar")], encoder) == "foo=%2Fbar%2Fbar"
    end

    test "ignores empty maps or lists" do
      assert encode(filter: %{}, foo: "bar", baz: "bat") == "foo=bar&baz=bat"
      assert encode(filter: [], foo: "bar", baz: "bat") == "foo=bar&baz=bat"
    end

    test "raises when there's a map with 0 or >1 elems in a list" do
      message = ~r/cannot encode maps inside lists/

      assert_raise ArgumentError, message, fn ->
        encode(%{foo: [%{a: 1, b: 2}]})
      end

      assert_raise ArgumentError, message, fn ->
        encode(%{foo: [%{valid: :map}, %{}]})
      end
    end
  end
end
