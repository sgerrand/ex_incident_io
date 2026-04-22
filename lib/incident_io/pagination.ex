defmodule IncidentIo.Pagination do
  @moduledoc """
  Helpers for iterating paginated incident.io API responses.

  The incident.io API uses cursor-based pagination. List endpoints that support
  pagination return a `pagination_meta` map with an `after` cursor. Pass that
  cursor as the `:after` option on the next call to advance to the next page.

  ## Example

      # Collect all incidents across all pages
      pages =
        IncidentIo.Pagination.stream(&IncidentIo.IncidentsV2.list/2, client)
        |> Enum.to_list()

      # Stream all schedules, processing each page lazily
      IncidentIo.Pagination.stream(&IncidentIo.SchedulesV2.list/2, client)
      |> Stream.each(fn %{schedules: page} -> process(page) end)
      |> Stream.run()

  ## Non-200 responses

  If a page request returns a non-200 status code, `stream/3` stops the stream
  and the page with the error status is **not** emitted. Call the underlying
  function directly if you need to inspect the error body.
  """

  @doc """
  Returns a lazy stream of pages from a paginated list function.

  `fun` must be a 2-arity function that accepts `(client, opts)` and returns
  an `IncidentIo.response()`. Each page body is emitted as an element of the
  stream.

  ## Options

  Any options accepted by `fun` can be passed in `opts`. The `:after` key is
  managed automatically and should not be set manually.

  ## Example

      IncidentIo.Pagination.stream(&IncidentIo.IncidentsV2.list/2, client)
      |> Enum.flat_map(fn %{incidents: incidents} -> incidents end)
  """
  @spec stream(
          fun :: (IncidentIo.Client.t(), keyword -> IncidentIo.response()),
          client :: IncidentIo.Client.t(),
          opts :: keyword
        ) :: Enumerable.t()
  def stream(fun, client, opts \\ []) do
    Stream.unfold(opts, fn
      :done ->
        nil

      acc ->
        case fun.(client, acc) do
          {200, %{pagination_meta: %{after: nil}} = body, _} ->
            {body, :done}

          {200, %{pagination_meta: %{after: cursor}} = body, _} ->
            {body, Keyword.put(acc, :after, cursor)}

          {200, body, _} ->
            # Response has no pagination_meta — treat as the only page
            {body, :done}

          _error ->
            nil
        end
    end)
  end
end
