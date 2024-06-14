defmodule IncidentIo.SchedulesV2 do
  @moduledoc """
  List configured schedules.
  """

  import IncidentIo
  alias IncidentIo.Client

  @typep request_options :: [
           after: nonempty_binary,
           page_size: pos_integer()
         ]
  @doc """
  Get a list of schedule entries.

  ## Example

      IncidentIo.SchedulesV2.list(client)

  More information at: https://api-docs.incident.io/tag/Schedules-V2#operation/Schedules%20V2_List
  """
  @spec list(Client.t(), request_options()) :: IncidentIo.response()
  def list(client \\ %Client{}, opts \\ []) do
    get(
      "v2/schedules",
      client,
      opts
    )
  end
end
