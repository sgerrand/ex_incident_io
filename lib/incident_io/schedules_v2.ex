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

  Schedule body example:
  ```elixir
  %{
    schedule: %{
      annotations: %{
        "incident.io/terraform/version": "version-of-terraform"
      },
      config: %{
        rotations: [
          %{
            effective_from: "2021-08-17T13:28:57.801578Z",
            handover_start_at: "2021-08-17T13:28:57.801578Z",
            handovers: [
              %{
                interval: 1,
                interval_type: "daily"
              }
            ],
            id: "01G0J1EXE7AXZ2C93K61WBPYEH",
            layers: [
              %{
                id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                name: "Layer 1"
              }
            ],
            name: "My Rotation",
            users: [
              %{
                email: "bob@example.com",
                id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                slack_user_id: "USER123"
              }
            ],
            working_interval: [
              %{
                end_time: "17:00",
                start_time: "09:00",
                weekday: "tuesday"
              }
            ]
          }
        ]
      },
      name: "My Schedule",
      timezone: "America/Los_Angeles"
    }
  }
  ```

  ## Example

      IncidentIo.SchedulesV2.create(client, body)

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

  @doc """
  Archives a single schedule.

  ## Example

      IncidentIo.SchedulesV2.destroy(client, "some-schedule-id")

  More information at: https://api-docs.incident.io/tag/Schedules-V2#operation/Schedules%20V2_Destroy
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete(
      "v2/schedules#{id}",
      client
    )
  end

  @doc """
  Get a single schedule.

  ## Example

      IncidentIo.SchedulesV2.show(client, "some-schedule-id")

  More information at: https://api-docs.incident.io/tag/Schedules-V2#operation/Schedules%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v2/schedules#{id}",
      client
    )
  end

  @doc """
  Update a schedule.

  Schedule body example:
  ```elixir
  %{
    schedule: %{
      annotations: %{
        "incident.io/terraform/version": "version-of-terraform"
      },
      config: %{
        rotations: [
          %{
            effective_from: "2021-08-17T13:28:57.801578Z",
            handover_start_at: "2021-08-17T13:28:57.801578Z",
            handovers: [
              %{
                interval: 1,
                interval_type: "daily"
              }
            ],
            id: "01G0J1EXE7AXZ2C93K61WBPYEH",
            layers: [
              %{
                id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                name: "Layer 1"
              }
            ],
            name: "My Rotation",
            users: [
              %{
                email: "bob@example.com",
                id: "01G0J1EXE7AXZ2C93K61WBPYEH",
                slack_user_id: "USER123"
              }
            ],
            working_interval: [
              %{
                end_time: "17:00",
                start_time: "09:00",
                weekday: "tuesday"
              }
            ]
          }
        ]
      },
      name: "My Schedule",
      timezone: "America/Los_Angeles"
    }
  }
  ```

  ## Example

      IncidentIo.SchedulesV2.update(client, body)

  More information at: https://api-docs.incident.io/tag/Schedules-V2#operation/Schedules%20V2_Update
  """
  @spec update(Client.t(), binary, request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put(
      "v2/schedules#{id}",
      client,
      body
    )
  end
end
