defmodule IncidentIo.ScheduleEntriesV2 do
  @moduledoc """
  Read schedule entries.
  """

  import IncidentIo
  alias IncidentIo.Client

  @typep request_options :: [
           entry_window_start: nonempty_binary,
           entry_window_end: nonempty_binary
         ]
  @doc """
  Get a list of schedule entries.

  ## Example

      IncidentIo.ScheduleEntriesV2.list(client)

  More information at: https://api-docs.incident.io/tag/Schedules-V2#operation/Schedules%20V2_ListScheduleEntries
  """
  @spec list(Client.t(), binary, request_options()) :: IncidentIo.response()
  def list(client \\ %Client{}, schedule_id, opts \\ []) do
    get(
      "v2/schedule_entries",
      client,
      [schedule_id: schedule_id] ++ opts
    )
  end
end
