defmodule IncidentIo.WorkflowsV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.WorkflowsV2

  doctest IncidentIo.WorkflowsV2

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "workflows#list" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "workflows#list" do
        {200, response, _} = list(@client)

        assert %{
                 workflows: [
                   %{
                     condition_groups: [
                       %{
                         conditions: [
                           %{
                             operation: %{
                               label: "Lawrence Jones",
                               value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                             },
                             param_bindings: [
                               %{
                                 array_value: [
                                   %{
                                     label: "Lawrence Jones",
                                     literal: "SEV123",
                                     reference: "incident.severity"
                                   }
                                 ],
                                 value: %{
                                   label: "Lawrence Jones",
                                   literal: "SEV123",
                                   reference: "incident.severity"
                                 }
                               }
                             ],
                             subject: %{
                               label: "Incident Severity",
                               reference: "incident.severity"
                             }
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
                                 label: "Lawrence Jones",
                                 literal: "SEV123",
                                 reference: "incident.severity"
                               }
                             ],
                             value: %{
                               label: "Lawrence Jones",
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
                                           operation: %{
                                             label: "Lawrence Jones",
                                             value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                                           },
                                           param_bindings: [
                                             %{
                                               array_value: [
                                                 %{
                                                   label: "Lawrence Jones",
                                                   literal: "SEV123",
                                                   reference: "incident.severity"
                                                 }
                                               ],
                                               value: %{
                                                 label: "Lawrence Jones",
                                                 literal: "SEV123",
                                                 reference: "incident.severity"
                                               }
                                             }
                                           ],
                                           subject: %{
                                             label: "Incident Severity",
                                             reference: "incident.severity"
                                           }
                                         }
                                       ]
                                     }
                                   ],
                                   result: %{
                                     array_value: [
                                       %{
                                         label: "Lawrence Jones",
                                         literal: "SEV123",
                                         reference: "incident.severity"
                                       }
                                     ],
                                     value: %{
                                       label: "Lawrence Jones",
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
                                       operation: %{
                                         label: "Lawrence Jones",
                                         value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                                       },
                                       param_bindings: [
                                         %{
                                           array_value: [
                                             %{
                                               label: "Lawrence Jones",
                                               literal: "SEV123",
                                               reference: "incident.severity"
                                             }
                                           ],
                                           value: %{
                                             label: "Lawrence Jones",
                                             literal: "SEV123",
                                             reference: "incident.severity"
                                           }
                                         }
                                       ],
                                       subject: %{
                                         label: "Incident Severity",
                                         reference: "incident.severity"
                                       }
                                     }
                                   ]
                                 }
                               ]
                             },
                             navigate: %{
                               reference: "1235",
                               reference_label: "Teams"
                             },
                             operation_type: "navigate",
                             parse: %{
                               returns: %{
                                 array: true,
                                 type: "IncidentStatus"
                               },
                               source: "metadata.annotations[\"github.com/repo\"]"
                             },
                             returns: %{
                               array: true,
                               type: "IncidentStatus"
                             }
                           }
                         ],
                         reference: "abc123",
                         returns: %{
                           array: true,
                           type: "IncidentStatus"
                         },
                         root_reference: "incident.status"
                       }
                     ],
                     folder: "My folder 01",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     include_private_incidents: true,
                     name: "My workflow",
                     once_for: [
                       %{
                         array: false,
                         key: "incident.custom_field[\"01FCNDV6P870EA6S7TK1DSYDG0\"]",
                         label: "Incident -> Affected Team",
                         type: "IncidentSeverity"
                       }
                     ],
                     runs_from: "2021-08-17T13:28:57.801578Z",
                     runs_on_incident_modes: [
                       "standard",
                       "retrospective"
                     ],
                     runs_on_incidents: "newly_created",
                     state: "active",
                     steps: [
                       %{
                         label: "PagerDuty Escalate",
                         name: "pagerduty.escalate"
                       }
                     ],
                     trigger: %{
                       label: "Incident Updated",
                       name: "incident.updated"
                     },
                     version: 3
                   }
                 ]
               } == response
      end
    end
  end

  describe "create/2" do
    @body %{
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

    test "returns expected HTTP status code" do
      use_cassette "workflows#create" do
        assert {201, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "workflows#create" do
        {201, response, _} = create(@client, @body)

        assert %{
                 management_meta: %{
                   annotations: %{
                     "incident.io/terraform/version": "3.0.0"
                   },
                   managed_by: "dashboard",
                   source_url: "https://github.com/my-company/infrastructure"
                 },
                 workflow: %{
                   condition_groups: [
                     %{
                       conditions: [
                         %{
                           operation: %{
                             label: "Lawrence Jones",
                             value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                           },
                           param_bindings: [
                             %{
                               array_value: [
                                 %{
                                   label: "Lawrence Jones",
                                   literal: "SEV123",
                                   reference: "incident.severity"
                                 }
                               ],
                               value: %{
                                 label: "Lawrence Jones",
                                 literal: "SEV123",
                                 reference: "incident.severity"
                               }
                             }
                           ],
                           subject: %{
                             label: "Incident Severity",
                             reference: "incident.severity"
                           }
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
                               label: "Lawrence Jones",
                               literal: "SEV123",
                               reference: "incident.severity"
                             }
                           ],
                           value: %{
                             label: "Lawrence Jones",
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
                                         operation: %{
                                           label: "Lawrence Jones",
                                           value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                                         },
                                         param_bindings: [
                                           %{
                                             array_value: [
                                               %{
                                                 label: "Lawrence Jones",
                                                 literal: "SEV123",
                                                 reference: "incident.severity"
                                               }
                                             ],
                                             value: %{
                                               label: "Lawrence Jones",
                                               literal: "SEV123",
                                               reference: "incident.severity"
                                             }
                                           }
                                         ],
                                         subject: %{
                                           label: "Incident Severity",
                                           reference: "incident.severity"
                                         }
                                       }
                                     ]
                                   }
                                 ],
                                 result: %{
                                   array_value: [
                                     %{
                                       label: "Lawrence Jones",
                                       literal: "SEV123",
                                       reference: "incident.severity"
                                     }
                                   ],
                                   value: %{
                                     label: "Lawrence Jones",
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
                                     operation: %{
                                       label: "Lawrence Jones",
                                       value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                                     },
                                     param_bindings: [
                                       %{
                                         array_value: [
                                           %{
                                             label: "Lawrence Jones",
                                             literal: "SEV123",
                                             reference: "incident.severity"
                                           }
                                         ],
                                         value: %{
                                           label: "Lawrence Jones",
                                           literal: "SEV123",
                                           reference: "incident.severity"
                                         }
                                       }
                                     ],
                                     subject: %{
                                       label: "Incident Severity",
                                       reference: "incident.severity"
                                     }
                                   }
                                 ]
                               }
                             ]
                           },
                           navigate: %{
                             reference: "1235",
                             reference_label: "Teams"
                           },
                           operation_type: "navigate",
                           parse: %{
                             returns: %{
                               array: true,
                               type: "IncidentStatus"
                             },
                             source: "metadata.annotations[\"github.com/repo\"]"
                           },
                           returns: %{
                             array: true,
                             type: "IncidentStatus"
                           }
                         }
                       ],
                       reference: "abc123",
                       returns: %{
                         array: true,
                         type: "IncidentStatus"
                       },
                       root_reference: "incident.status"
                     }
                   ],
                   folder: "My folder 01",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   include_private_incidents: true,
                   name: "My workflow",
                   once_for: [
                     %{
                       array: false,
                       key: "incident.custom_field[\"01FCNDV6P870EA6S7TK1DSYDG0\"]",
                       label: "Incident -> Affected Team",
                       type: "IncidentSeverity"
                     }
                   ],
                   runs_from: "2021-08-17T13:28:57.801578Z",
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
                       label: "PagerDuty Escalate",
                       name: "pagerduty.escalate",
                       param_bindings: [
                         %{
                           array_value: [
                             %{
                               label: "Lawrence Jones",
                               literal: "SEV123",
                               reference: "incident.severity"
                             }
                           ],
                           value: %{
                             label: "Lawrence Jones",
                             literal: "SEV123",
                             reference: "incident.severity"
                           }
                         }
                       ]
                     }
                   ],
                   trigger: %{
                     label: "Incident Updated",
                     name: "incident.updated"
                   },
                   version: 3
                 }
               } == response
      end
    end
  end

  describe "destroy/2" do
    test "returns expected HTTP status code" do
      use_cassette "workflows#delete" do
        assert {204, _, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "workflows#delete" do
        {204, response, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert nil == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "workflows#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "workflows#show" do
        {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 management_meta: %{
                   annotations: %{
                     "incident.io/terraform/version": "3.0.0"
                   },
                   managed_by: "dashboard",
                   source_url: "https://github.com/my-company/infrastructure"
                 },
                 workflow: %{
                   condition_groups: [
                     %{
                       conditions: [
                         %{
                           operation: %{
                             label: "Lawrence Jones",
                             value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                           },
                           param_bindings: [
                             %{
                               array_value: [
                                 %{
                                   label: "Lawrence Jones",
                                   literal: "SEV123",
                                   reference: "incident.severity"
                                 }
                               ],
                               value: %{
                                 label: "Lawrence Jones",
                                 literal: "SEV123",
                                 reference: "incident.severity"
                               }
                             }
                           ],
                           subject: %{
                             label: "Incident Severity",
                             reference: "incident.severity"
                           }
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
                               label: "Lawrence Jones",
                               literal: "SEV123",
                               reference: "incident.severity"
                             }
                           ],
                           value: %{
                             label: "Lawrence Jones",
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
                                         operation: %{
                                           label: "Lawrence Jones",
                                           value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                                         },
                                         param_bindings: [
                                           %{
                                             array_value: [
                                               %{
                                                 label: "Lawrence Jones",
                                                 literal: "SEV123",
                                                 reference: "incident.severity"
                                               }
                                             ],
                                             value: %{
                                               label: "Lawrence Jones",
                                               literal: "SEV123",
                                               reference: "incident.severity"
                                             }
                                           }
                                         ],
                                         subject: %{
                                           label: "Incident Severity",
                                           reference: "incident.severity"
                                         }
                                       }
                                     ]
                                   }
                                 ],
                                 result: %{
                                   array_value: [
                                     %{
                                       label: "Lawrence Jones",
                                       literal: "SEV123",
                                       reference: "incident.severity"
                                     }
                                   ],
                                   value: %{
                                     label: "Lawrence Jones",
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
                                     operation: %{
                                       label: "Lawrence Jones",
                                       value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                                     },
                                     param_bindings: [
                                       %{
                                         array_value: [
                                           %{
                                             label: "Lawrence Jones",
                                             literal: "SEV123",
                                             reference: "incident.severity"
                                           }
                                         ],
                                         value: %{
                                           label: "Lawrence Jones",
                                           literal: "SEV123",
                                           reference: "incident.severity"
                                         }
                                       }
                                     ],
                                     subject: %{
                                       label: "Incident Severity",
                                       reference: "incident.severity"
                                     }
                                   }
                                 ]
                               }
                             ]
                           },
                           navigate: %{
                             reference: "1235",
                             reference_label: "Teams"
                           },
                           operation_type: "navigate",
                           parse: %{
                             returns: %{
                               array: true,
                               type: "IncidentStatus"
                             },
                             source: "metadata.annotations[\"github.com/repo\"]"
                           },
                           returns: %{
                             array: true,
                             type: "IncidentStatus"
                           }
                         }
                       ],
                       reference: "abc123",
                       returns: %{
                         array: true,
                         type: "IncidentStatus"
                       },
                       root_reference: "incident.status"
                     }
                   ],
                   folder: "My folder 01",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   include_private_incidents: true,
                   name: "My workflow",
                   once_for: [
                     %{
                       array: false,
                       key: "incident.custom_field[\"01FCNDV6P870EA6S7TK1DSYDG0\"]",
                       label: "Incident -> Affected Team",
                       type: "IncidentSeverity"
                     }
                   ],
                   runs_from: "2021-08-17T13:28:57.801578Z",
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
                       label: "PagerDuty Escalate",
                       name: "pagerduty.escalate",
                       param_bindings: [
                         %{
                           array_value: [
                             %{
                               label: "Lawrence Jones",
                               literal: "SEV123",
                               reference: "incident.severity"
                             }
                           ],
                           value: %{
                             label: "Lawrence Jones",
                             literal: "SEV123",
                             reference: "incident.severity"
                           }
                         }
                       ]
                     }
                   ],
                   trigger: %{
                     label: "Incident Updated",
                     name: "incident.updated"
                   },
                   version: 3
                 }
               } == response
      end
    end
  end

  describe "update/3" do
    @body %{
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

    test "returns expected HTTP status code" do
      use_cassette "workflows#update" do
        assert {200, _, _} = update(@client, "01G0J1EXE7AXZ2C93K61WBPYEH", @body)
      end
    end

    test "returns expected response" do
      use_cassette "workflows#update" do
        {200, response, _} = update(@client, "01G0J1EXE7AXZ2C93K61WBPYEH", @body)

        assert %{
                 management_meta: %{
                   annotations: %{
                     "incident.io/terraform/version": "3.0.0"
                   },
                   managed_by: "dashboard",
                   source_url: "https://github.com/my-company/infrastructure"
                 },
                 workflow: %{
                   condition_groups: [
                     %{
                       conditions: [
                         %{
                           operation: %{
                             label: "Lawrence Jones",
                             value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                           },
                           param_bindings: [
                             %{
                               array_value: [
                                 %{
                                   label: "Lawrence Jones",
                                   literal: "SEV123",
                                   reference: "incident.severity"
                                 }
                               ],
                               value: %{
                                 label: "Lawrence Jones",
                                 literal: "SEV123",
                                 reference: "incident.severity"
                               }
                             }
                           ],
                           subject: %{
                             label: "Incident Severity",
                             reference: "incident.severity"
                           }
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
                               label: "Lawrence Jones",
                               literal: "SEV123",
                               reference: "incident.severity"
                             }
                           ],
                           value: %{
                             label: "Lawrence Jones",
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
                                         operation: %{
                                           label: "Lawrence Jones",
                                           value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                                         },
                                         param_bindings: [
                                           %{
                                             array_value: [
                                               %{
                                                 label: "Lawrence Jones",
                                                 literal: "SEV123",
                                                 reference: "incident.severity"
                                               }
                                             ],
                                             value: %{
                                               label: "Lawrence Jones",
                                               literal: "SEV123",
                                               reference: "incident.severity"
                                             }
                                           }
                                         ],
                                         subject: %{
                                           label: "Incident Severity",
                                           reference: "incident.severity"
                                         }
                                       }
                                     ]
                                   }
                                 ],
                                 result: %{
                                   array_value: [
                                     %{
                                       label: "Lawrence Jones",
                                       literal: "SEV123",
                                       reference: "incident.severity"
                                     }
                                   ],
                                   value: %{
                                     label: "Lawrence Jones",
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
                                     operation: %{
                                       label: "Lawrence Jones",
                                       value: "01FCQSP07Z74QMMYPDDGQB9FTG"
                                     },
                                     param_bindings: [
                                       %{
                                         array_value: [
                                           %{
                                             label: "Lawrence Jones",
                                             literal: "SEV123",
                                             reference: "incident.severity"
                                           }
                                         ],
                                         value: %{
                                           label: "Lawrence Jones",
                                           literal: "SEV123",
                                           reference: "incident.severity"
                                         }
                                       }
                                     ],
                                     subject: %{
                                       label: "Incident Severity",
                                       reference: "incident.severity"
                                     }
                                   }
                                 ]
                               }
                             ]
                           },
                           navigate: %{
                             reference: "1235",
                             reference_label: "Teams"
                           },
                           operation_type: "navigate",
                           parse: %{
                             returns: %{
                               array: true,
                               type: "IncidentStatus"
                             },
                             source: "metadata.annotations[\"github.com/repo\"]"
                           },
                           returns: %{
                             array: true,
                             type: "IncidentStatus"
                           }
                         }
                       ],
                       reference: "abc123",
                       returns: %{
                         array: true,
                         type: "IncidentStatus"
                       },
                       root_reference: "incident.status"
                     }
                   ],
                   folder: "My folder 01",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   include_private_incidents: true,
                   name: "My workflow",
                   once_for: [
                     %{
                       array: false,
                       key: "incident.custom_field[\"01FCNDV6P870EA6S7TK1DSYDG0\"]",
                       label: "Incident -> Affected Team",
                       type: "IncidentSeverity"
                     }
                   ],
                   runs_from: "2021-08-17T13:28:57.801578Z",
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
                       label: "PagerDuty Escalate",
                       name: "pagerduty.escalate",
                       param_bindings: [
                         %{
                           array_value: [
                             %{
                               label: "Lawrence Jones",
                               literal: "SEV123",
                               reference: "incident.severity"
                             }
                           ],
                           value: %{
                             label: "Lawrence Jones",
                             literal: "SEV123",
                             reference: "incident.severity"
                           }
                         }
                       ]
                     }
                   ],
                   trigger: %{
                     label: "Incident Updated",
                     name: "incident.updated"
                   },
                   version: 3
                 }
               } == response
      end
    end
  end
end
