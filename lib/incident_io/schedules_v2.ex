defmodule IncidentIo.SchedulesV2 do
  @moduledoc """
  List configured schedules.
  """

  import IncidentIo
  alias IncidentIo.Client

  @typep handover :: %{
           optional(:interval) => pos_integer(),
           optional(:interval_type) => interval_type()
         }
  @typep interval_type :: :hourly | :daily | :weekly
  @typep layer :: %{
           optional(:id) => binary,
           name: nonempty_binary
         }
  @typep request_body :: %{
           schedule: %{
             optional(:annotations) => %{
               nonempty_binary() => binary
             },
             optional(:config) => %{
               rotations: [rotation(), ...]
             },
             optional(:name) => binary,
             optional(:timezone) => binary
           }
         }
  @typep request_options :: [
           after: nonempty_binary,
           page_size: pos_integer()
         ]
  @typep rotation :: %{
           optional(:effective_from) => binary,
           optional(:handover_start_at) => binary,
           optional(:handover) => [handover(), ...],
           optional(:id) => binary,
           optional(:layers) => [layer(), ...],
           optional(:users) => [user(), ...],
           optional(:working_interval) => [working_interval, ...],
           name: nonempty_binary()
         }
  @typep user :: %{
           optional(:email) => binary,
           optional(:id) => binary,
           optional(:slack_user_id) => binary
         }
  @typep weekday :: :monday | :tuesday | :wednesday | :thursday | :friday | :saturday | :sunday
  @typep working_interval :: %{
           end_time: binary,
           start_time: binary,
           weekday: weekday()
         }

  @doc """
  Get a list of schedules.

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

  @doc """
  Create a new schedule.

  ## Example

      IncidentIo.SchedulesV2.create(client)

  More information at: https://api-docs.incident.io/tag/Schedules-V2#operation/Schedules%20V2_Create
  """
  @spec create(Client.t(), request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v2/schedules",
      client,
      body
    )
  end
end
