defmodule IncidentIo.WorkflowsV2 do
  @moduledoc """
  Manage workflows.

  Workflows allow you to automate certain actions and behaviors based on
  specific triggers.
  """

  import IncidentIo
  alias IncidentIo.Client

  @typep annotations :: %{
           optional(binary) => binary
         }
  @typep branch :: %{
           condition_groups: condition_groups(),
           result: result()
         }
  @typep condition :: %{
           operation: binary,
           param_bindings: [param_binding, ...],
           subject: binary
         }
  @typep conditions :: %{
           condition: [condition(), ...]
         }
  @typep condition_groups :: [conditions(), ...]
  @typep engine_param_binding_value :: %{
           optional(:literal) => binary,
           optional(:reference) => binary
         }
  @typep expression :: %{
           optional(:else_branch) => %{
             result: result()
           },
           label: binary,
           operations: [operation(), ...],
           reference: binary,
           root_reference: binary
         }
  @typep incident_modes :: :standard | :test | :retrospective
  @typep incident_states :: :newly_created | :newly_created_and_active
  @typep operation :: %{
           branches: %{
             branches: [branch(), ...],
             returns: returns()
           },
           filter: %{},
           navigate: %{},
           operation_type: operation_type(),
           parse: %{
             returns: returns(),
             source: binary
           }
         }
  @typep operation_type ::
           :navigate | :filter | :count | :min | :max | :random | :first | :parse | :branches
  @typep param_binding :: %{
           optional(:array_value) => [engine_param_binding_value(), ...],
           optional(:value) => binary
         }
  @typep result :: %{
           array_value: [engine_param_binding_value(), ...],
           value: engine_param_binding_value()
         }
  @typep returns :: %{
           array: bool,
           type: binary
         }
  @typep request_body :: %{
           optional(:annotations) => annotations(),
           required(:condition_groups) => condition_groups(),
           required(:continue_on_step_error) => bool,
           optional(:delay) => %{
             conditions_apply_over_delay: bool,
             for_seconds: pos_integer
           },
           required(:expressions) => [expression(), ...],
           optional(:folder) => binary,
           required(:include_private_incidents) => bool,
           required(:name) => binary,
           required(:once_for) => [binary, ...],
           required(:runs_on_incident_modes) => [incident_modes(), ...],
           required(:runs_on_incidents) => incident_states(),
           optional(:state) => states(),
           required(:steps) => [step(), ...],
           required(:trigger) => binary
         }
  @typep states :: :active | :disabled | :draft | :error
  @typep step :: %{
           optional(:for_each) => binary,
           required(:id) => binary,
           required(:name) => binary,
           required(:param_bindings) => [param_binding(), ...]
         }

  @doc """
  List all workflows for an organisation.

  ## Example

      IncidentIo.WorkflowsV2.list(client)

  More information at: https://api-docs.incident.io/tag/Workflows-V2#operation/Workflows%20V2_List
  """
  @spec list(Client.t()) :: IncidentIo.response()
  def list(client \\ %Client{}) do
    get(
      "v2/workflows",
      client
    )
  end

  @doc """
  Create a new workflow.

  Workflow body example:
  ```elixir
  %{
    annotations: %{
      "incident.io/terraform/version": "3.0.0"
    },
    condition_groups: [
      %{
        conditions: [
          %{
            operation: "one_of",
            param_bindings: [
              %{
                array_value: [
                  %{
                    literal: "SEV123",
                    reference: "incident.severity"
                  }
                ],
                value: %{
                  literal: "SEV123",
                  reference: "incident.severity"
                }
              }
            ],
            subject: "incident.severity"
          }
        ]
      }
    ],
    continue_on_step_error: true,
    delay: %{
      conditions_apply_over_delay: false,
      for_seconds: 60
    },
    expressions: [
      %{
        else_branch: %{
          result: %{
            array_value: [
              %{
                literal: "SEV123",
                reference: "incident.severity"
              }
            ],
            value: %{
              literal: "SEV123",
              reference: "incident.severity"
            }
          }
        },
        label: "Team Slack channel",
        operations: [
          %{
            branches: %{
              branches: [
                %{
                  condition_groups: [
                    %{
                      conditions: [
                        %{
                          operation: "one_of",
                          param_bindings: [
                            %{
                              array_value: [
                                %{
                                  literal: "SEV123",
                                  reference: "incident.severity"
                                }
                              ],
                              value: %{
                                literal: "SEV123",
                                reference: "incident.severity"
                              }
                            }
                          ],
                          subject: "incident.severity"
                        }
                      ]
                    }
                  ],
                  result: %{
                    array_value: [
                      %{
                        literal: "SEV123",
                        reference: "incident.severity"
                      }
                    ],
                    value: %{
                      literal: "SEV123",
                      reference: "incident.severity"
                    }
                  }
                }
              ],
              returns: %{
                array: true,
                type: "IncidentStatus"
              }
            },
            filter: %{
              condition_groups: [
                %{
                  conditions: [
                    %{
                      operation: "one_of",
                      param_bindings: [
                        %{
                          array_value: [
                            %{
                              literal: "SEV123",
                              reference: "incident.severity"
                            }
                          ],
                          value: %{
                            literal: "SEV123",
                            reference: "incident.severity"
                          }
                        }
                      ],
                      subject: "incident.severity"
                    }
                  ]
                }
              ]
            },
            navigate: %{
              reference: "catalog_attribute[\"01FCNDV6P870EA6S7TK1DSYD5H\"]"
            },
            operation_type: "navigate",
            parse: %{
              returns: %{
                array: true,
                type: "IncidentStatus"
              },
              source: "metadata.annotations[\"github.com/repo\"]"
            }
          }
        ],
        reference: "abc123",
        root_reference: "incident.status"
      }
    ],
    folder: "My folder 01",
    include_private_incidents: true,
    name: "My workflow",
    once_for: [
      "incident.url"
    ],
    runs_on_incident_modes: [
      "standard",
      "retrospective"
    ],
    runs_on_incidents: "newly_created",
    state: "active",
    steps: [
      %{
        for_each: "abc123",
        id: "abc123",
        name: "pagerduty.escalate",
        param_bindings: [
          %{
            array_value: [
              %{
                literal: "SEV123",
                reference: "incident.severity"
              }
            ],
            value: %{
              literal: "SEV123",
              reference: "incident.severity"
            }
          }
        ]
      }
    ],
    trigger: "incident.updated"
  }
  ```

  ## Example

      IncidentIo.WorkflowsV2.create(client, body)

  More information at: https://api-docs.incident.io/tag/Workflows-V2#operation/Workflows%20V2_Create
  """
  @spec create(Client.t(), request_body()) :: IncidentIo.response()
  def create(client \\ %Client{}, body) do
    post(
      "v2/workflows",
      client,
      body
    )
  end

  @doc """
  Archive an existing workflow.

  ## Example

      IncidentIo.WorkflowsV2.destroy(client, "some-workflow-id")

  More information at: https://api-docs.incident.io/tag/Workflows-V2#operation/Workflows%20V2_Delete
  """
  @spec destroy(Client.t(), binary) :: IncidentIo.response()
  def destroy(client \\ %Client{}, id) do
    delete(
      "v2/workflows/#{id}",
      client
    )
  end

  @doc """
  Get a single workflow.

  ## Example

      IncidentIo.WorkflowsV2.show(client, "some-workflow-id")

  More information at: https://api-docs.incident.io/tag/Workflows-V2#operation/Workflows%20V2_Show
  """
  @spec show(Client.t(), binary) :: IncidentIo.response()
  def show(client \\ %Client{}, id) do
    get(
      "v2/workflows/#{id}",
      client
    )
  end

  @doc """
  Update an existing workflow.

  Workflow body example:
  ```elixir
  %{
    annotations: %{
      "incident.io/terraform/version": "3.0.0"
    },
    condition_groups: [
      %{
        conditions: [
          %{
            operation: "one_of",
            param_bindings: [
              %{
                array_value: [
                  %{
                    literal: "SEV123",
                    reference: "incident.severity"
                  }
                ],
                value: %{
                  literal: "SEV123",
                  reference: "incident.severity"
                }
              }
            ],
            subject: "incident.severity"
          }
        ]
      }
    ],
    continue_on_step_error: true,
    delay: %{
      conditions_apply_over_delay: false,
      for_seconds: 60
    },
    expressions: [
      %{
        else_branch: %{
          result: %{
            array_value: [
              %{
                literal: "SEV123",
                reference: "incident.severity"
              }
            ],
            value: %{
              literal: "SEV123",
              reference: "incident.severity"
            }
          }
        },
        label: "Team Slack channel",
        operations: [
          %{
            branches: %{
              branches: [
                %{
                  condition_groups: [
                    %{
                      conditions: [
                        %{
                          operation: "one_of",
                          param_bindings: [
                            %{
                              array_value: [
                                %{
                                  literal: "SEV123",
                                  reference: "incident.severity"
                                }
                              ],
                              value: %{
                                literal: "SEV123",
                                reference: "incident.severity"
                              }
                            }
                          ],
                          subject: "incident.severity"
                        }
                      ]
                    }
                  ],
                  result: %{
                    array_value: [
                      %{
                        literal: "SEV123",
                        reference: "incident.severity"
                      }
                    ],
                    value: %{
                      literal: "SEV123",
                      reference: "incident.severity"
                    }
                  }
                }
              ],
              returns: %{
                array: true,
                type: "IncidentStatus"
              }
            },
            filter: %{
              condition_groups: [
                %{
                  conditions: [
                    %{
                      operation: "one_of",
                      param_bindings: [
                        %{
                          array_value: [
                            %{
                              literal: "SEV123",
                              reference: "incident.severity"
                            }
                          ],
                          value: %{
                            literal: "SEV123",
                            reference: "incident.severity"
                          }
                        }
                      ],
                      subject: "incident.severity"
                    }
                  ]
                }
              ]
            },
            navigate: %{
              reference: "catalog_attribute[\"01FCNDV6P870EA6S7TK1DSYD5H\"]"
            },
            operation_type: "navigate",
            parse: %{
              returns: %{
                array: true,
                type: "IncidentStatus"
              },
              source: "metadata.annotations[\"github.com/repo\"]"
            }
          }
        ],
        reference: "abc123",
        root_reference: "incident.status"
      }
    ],
    folder: "My folder 01",
    include_private_incidents: true,
    name: "My workflow",
    once_for: [
      "incident.url"
    ],
    runs_on_incident_modes: [
      "standard",
      "retrospective"
    ],
    runs_on_incidents: "newly_created",
    state: "active",
    steps: [
      %{
        for_each: "abc123",
        id: "abc123",
        name: "pagerduty.escalate",
        param_bindings: [
          %{
            array_value: [
              %{
                literal: "SEV123",
                reference: "incident.severity"
              }
            ],
            value: %{
              literal: "SEV123",
              reference: "incident.severity"
            }
          }
        ]
      }
    ],
    trigger: "incident.updated"
  }
  ```

  ## Example

      IncidentIo.WorkflowsV2.update(client, "some-workflow-id", body)

  More information at: https://api-docs.incident.io/tag/Workflows-V2#operation/Workflows%20V2_Update
  """
  @spec update(Client.t(), binary, request_body()) :: IncidentIo.response()
  def update(client \\ %Client{}, id, body) do
    put(
      "v2/workflows/#{id}",
      client,
      body
    )
  end
end
