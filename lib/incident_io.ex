defmodule IncidentIo do
  @moduledoc """
  `IncidentIo` is an Elixir client for the Incident.io API.
  """

  use HTTPoison.Base
  alias IncidentIo.Client
  alias IncidentIo.Query
  alias Jason

  @user_agent [{"User-agent", "IncidentIo/elixir"}]

  @type response ::
          {:ok, term, HTTPoison.Response.t()}
          | {integer, any, HTTPoison.Response.t()}
          | pagination_response

  @type pagination_response :: {response, binary | nil, Client.auth()}

  @type deprecated_incident_mode :: :real | :test | :tutorial
  @type deprecated_incident_modes :: [:real | :test | :tutorial]
  @type incident_mode :: :standard | :retrospective | :test | :tutorial | :stream
  @type incident_modes :: [:standard | :retrospective | :test | :tutorial | :stream]

  defmodule JsonString do
    @moduledoc false
    defstruct [:body]
  end

  defimpl Jason.Encoder, for: JsonString do
    def encode(%JsonString{body: body}, _opts) when is_nil(body) do
      ""
    end

    def encode(%JsonString{body: body}, opts) when is_binary(body) do
      case body do
        "" -> body
        _ -> Jason.Encode.string(body, opts)
      end
    end

    def encode(%JsonString{body: body}, opts) when is_map(body) do
      Jason.Encode.map(body, opts)
    end
  end

  defimpl Jason.Encoder, for: Tuple do
    def encode(tuple, opts) when is_tuple(tuple) do
      [tuple]
      |> Enum.into(%{})
      |> Jason.Encode.map(opts)
    end
  end

  @spec process_response_body(binary) :: term
  def process_response_body(""), do: nil

  def process_response_body(body), do: IncidentIo.Json.decode!(body, deserialization_options())

  @spec process_response(HTTPoison.Response.t() | {integer, any, HTTPoison.Response.t()}) ::
          response
  def process_response(%HTTPoison.Response{status_code: status_code, body: body} = resp),
    do: {status_code, body, resp}

  def process_response({_status_code, _, %HTTPoison.Response{} = resp}),
    do: process_response(resp)

  @spec delete(binary, Client.t(), any) :: response
  def delete(path, client, body \\ "") do
    _request(:delete, url(client, path), client.auth, body)
  end

  @spec post(binary, Client.t(), any) :: response
  def post(path, client, body \\ "") do
    _request(:post, url(client, path), client.auth, body)
  end

  @spec put(binary, Client.t(), any) :: response
  def put(path, client, body \\ "") do
    _request(:put, url(client, path), client.auth, body)
  end

  @spec get(binary, Client.t()) :: response
  @spec get(binary, Client.t(), keyword) :: response
  def get(path, client, params \\ []) do
    url =
      client
      |> url(path)
      |> add_params_to_url(params)

    _request(:get, url, client.auth, "")
  end

  @spec _request(atom, binary, Client.auth(), any) :: response
  def _request(method, url, auth, body \\ ""),
    do: json_request(method, url, body, authorization_header(auth, @user_agent))

  @spec json_request(atom, binary, any, keyword, keyword) :: response
  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    raw_request(method, url, Jason.encode!(%JsonString{body: body}), headers, options)
  end

  defp extra_options do
    Application.get_env(:incident_io, :request_options, [])
  end

  defp extra_headers do
    Application.get_env(:incident_io, :extra_headers, [
      {"Accept", "application/json"},
      {"Content-Type", "application/json"}
    ])
  end

  defp deserialization_options do
    Application.get_env(:incident_io, :deserialization_options, labels: :binary, keys: :atoms)
  end

  def raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
    method
    |> request!(url, body, extra_headers() ++ headers, extra_options() ++ options)
    |> process_response
  end

  @spec url(client :: Client.t(), path :: binary) :: binary
  defp url(%Client{endpoint: endpoint} = _client, path) do
    endpoint <> path
  end

  @doc """
  Take an existing URI and add addition params, appending and replacing as necessary.

  ## Examples

      iex> add_params_to_url("http://example.com/wat", [])
      "http://example.com/wat"

      iex> add_params_to_url("http://example.com/wat", [q: 1])
      "http://example.com/wat?q=1"

      iex> add_params_to_url("http://example.com/wat", [q: 1, t: 2])
      "http://example.com/wat?q=1&t=2"

      iex> add_params_to_url("http://example.com/wat", %{q: 1, t: 2})
      "http://example.com/wat?q=1&t=2"

      iex> add_params_to_url("http://example.com/wat?q=1&t=2", [])
      "http://example.com/wat?q=1&t=2"

      iex> add_params_to_url("http://example.com/wat?q=1", [t: 2])
      "http://example.com/wat?q=1&t=2"

      iex> add_params_to_url("http://example.com/wat?q=1", [q: 3, t: 2])
      "http://example.com/wat?q=3&t=2"

      iex> add_params_to_url("http://example.com/wat?q=1&s=4", [q: 3, t: 2])
      "http://example.com/wat?q=3&s=4&t=2"

      iex> add_params_to_url("http://example.com/wat?q=1&s=4", [q: 3, t: 2, u: [o: 1, v: 0]])
      "http://example.com/wat?q=3&s=4&t=2&u[o]=1&u[v]=0"

      iex> add_params_to_url("http://example.com/wat?q=1&s=4", [q: 3, t: 2, u: [1, "two", 3]])
      "http://example.com/wat?q=3&s=4&t=2&u[]=1&u[]=two&u[]=3"

      iex> add_params_to_url("http://example.com/wat?q=1&s=4", %{q: 3, t: 2})
      "http://example.com/wat?q=3&s=4&t=2"

      iex> add_params_to_url("http://example.com/wat?q=1&s=4", %{q: 3, t: 2, u: [o: 1, v: 0]})
      "http://example.com/wat?q=3&s=4&t=2&u[o]=1&u[v]=0"

      iex> add_params_to_url("http://example.com/wat?q=1&s=4", %{q: 3, t: 2, u: [1, "two", 3]})
      "http://example.com/wat?q=3&s=4&t=2&u[]=1&u[]=two&u[]=3"

  """
  @spec add_params_to_url(binary, list) :: binary
  def add_params_to_url(url, params) do
    url
    |> URI.parse()
    |> merge_uri_params(params)
    |> String.Chars.to_string()
  end

  @spec merge_uri_params(URI.t(), list) :: URI.t()
  defp merge_uri_params(uri, []), do: uri

  defp merge_uri_params(%URI{query: nil} = uri, params) when is_list(params) or is_map(params) do
    uri
    |> Map.put(:query, Query.encode(params))
  end

  defp merge_uri_params(%URI{} = uri, params) when is_list(params) or is_map(params) do
    uri
    |> Map.update!(:query, fn q ->
      q
      |> Query.decode()
      |> Map.merge(param_list_to_map_with_string_keys(params))
      |> Query.encode()
    end)
  end

  @spec param_list_to_map_with_string_keys(list) :: map
  defp param_list_to_map_with_string_keys(list) when is_list(list) or is_map(list) do
    for {key, value} <- list, into: Map.new() do
      {"#{key}", value}
    end
  end

  @doc """
  Use a JWT bearer token to authenticate to the Incident.io API:

  ## Examples

      iex> IncidentIo.authorization_header(%{api_key: "92873971893"}, [])
      [{"Authorization", "Bearer 92873971893"}]

  More info at: https://api-docs.incident.io/#section/Making-requests/Authentication
  """
  @spec authorization_header(Client.auth(), list) :: list
  def authorization_header(%{api_key: api_key}, headers) do
    headers ++ [{"Authorization", "Bearer #{api_key}"}]
  end

  def authorization_header(_, headers), do: headers

  @doc """
  Same as `authorization_header/2` but defaults initial headers to include `@user_agent`.
  """
  def authorization_header(options), do: authorization_header(options, @user_agent)
end
