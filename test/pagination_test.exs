defmodule IncidentIo.PaginationTest do
  use IncidentIo.TestCase, async: true

  doctest IncidentIo.Pagination

  alias IncidentIo.Pagination

  @client IncidentIo.Client.new()

  defp page(items, after_cursor) do
    %{
      items: items,
      pagination_meta: %{after: after_cursor, page_size: 25, total_record_count: 3}
    }
  end

  describe "stream/3" do
    test "emits all pages and stops when after cursor is nil" do
      pages = [
        {200, page(["a", "b"], "cursor1"), nil},
        {200, page(["c"], nil), nil}
      ]

      call_count = :counters.new(1, [])
      results_ref = :ets.new(:pages, [:set, :public])
      :ets.insert(results_ref, {:pages, pages})

      fun = fn _client, opts ->
        :counters.add(call_count, 1, 1)
        [{:pages, remaining}] = :ets.lookup(results_ref, :pages)
        [_current | rest] = remaining
        :ets.insert(results_ref, {:pages, rest})

        after_val = Keyword.get(opts, :after)

        case after_val do
          nil -> Enum.at(pages, 0)
          "cursor1" -> Enum.at(pages, 1)
        end
      end

      result = Pagination.stream(fun, @client) |> Enum.to_list()

      assert length(result) == 2
      assert [%{items: ["a", "b"]}, %{items: ["c"]}] = result
    end

    test "emits a single page when response has no pagination_meta" do
      fun = fn _client, _opts ->
        {200, %{items: ["x", "y"]}, nil}
      end

      result = Pagination.stream(fun, @client) |> Enum.to_list()

      assert [%{items: ["x", "y"]}] = result
    end

    test "stops stream on non-200 response" do
      fun = fn _client, _opts ->
        {401, %{type: "authentication_error"}, nil}
      end

      result = Pagination.stream(fun, @client) |> Enum.to_list()

      assert result == []
    end

    test "passes initial opts to the function" do
      received_opts = :ets.new(:opts, [:set, :public])

      fun = fn _client, opts ->
        :ets.insert(received_opts, {:opts, opts})
        {200, %{items: []}, nil}
      end

      Pagination.stream(fun, @client, page_size: 10) |> Enum.to_list()

      [{:opts, opts}] = :ets.lookup(received_opts, :opts)
      assert Keyword.get(opts, :page_size) == 10
    end

    test "emits one empty page when first page has no items and nil cursor" do
      fun = fn _client, _opts ->
        {200, page([], nil), nil}
      end

      result = Pagination.stream(fun, @client) |> Enum.to_list()

      assert [%{items: []}] = result
    end

    test "stops stream mid-pagination on non-200 response and omits error page" do
      fun = fn _client, opts ->
        case Keyword.get(opts, :after) do
          nil -> {200, page(["a"], "cursor1"), nil}
          _ -> {500, %{message: "internal error"}, nil}
        end
      end

      result = Pagination.stream(fun, @client) |> Enum.to_list()

      assert [%{items: ["a"]}] = result
    end

    test "forwards the after cursor from pagination_meta into subsequent requests" do
      received_cursors = :ets.new(:cursors, [:bag, :public])

      fun = fn _client, opts ->
        cursor = Keyword.get(opts, :after)
        :ets.insert(received_cursors, {:cursor, cursor})

        case cursor do
          nil -> {200, page(["a"], "page2"), nil}
          "page2" -> {200, page(["b"], nil), nil}
        end
      end

      Pagination.stream(fun, @client) |> Enum.to_list()

      cursors = :ets.lookup(received_cursors, :cursor) |> Enum.map(fn {_, v} -> v end)
      assert nil in cursors
      assert "page2" in cursors
    end
  end
end
