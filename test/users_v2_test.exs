defmodule IncidentIo.UsersV2Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.UsersV2

  doctest IncidentIo.UsersV2

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            pagination_meta: %{
              after: "01FCNDV6P870EA6S7TK1DSYDG0",
              page_size: 25
            },
            users: [
              %{
                base_role: %{
                  description: "Elevated permissions for the customer success team.",
                  id: "01FCNDV6P870EA6S7TK1DSYDG0",
                  name: "Customer Success",
                  slug: "customer-success"
                },
                custom_roles: [
                  %{
                    description: "Elevated permissions for the customer success team.",
                    id: "01FCNDV6P870EA6S7TK1DSYDG0",
                    name: "Customer Success",
                    slug: "customer-success"
                  }
                ],
                email: "lisa@incident.io",
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                name: "Lisa Karlin Curtis",
                role: "viewer",
                slack_user_id: "U02AYNF2XJM"
              }
            ]
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client)
    end

    test "returns expected response" do
      {200, response, _} = list(@client)

      assert %{
               pagination_meta: %{
                 after: "01FCNDV6P870EA6S7TK1DSYDG0",
                 page_size: 25
               },
               users: [
                 %{
                   base_role: %{
                     description: "Elevated permissions for the customer success team.",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     name: "Customer Success",
                     slug: "customer-success"
                   },
                   custom_roles: [
                     %{
                       description: "Elevated permissions for the customer success team.",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       name: "Customer Success",
                       slug: "customer-success"
                     }
                   ],
                   email: "lisa@incident.io",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Lisa Karlin Curtis",
                   role: "viewer",
                   slack_user_id: "U02AYNF2XJM"
                 }
               ]
             } == response
    end
  end

  describe "list/2" do
    test "with optional params" do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            pagination_meta: %{
              after: "01FDAG4SAP5TYPT98WGR2N7W91",
              page_size: 10
            },
            users: [
              %{
                base_role: %{
                  description: "Elevated permissions for the customer success team.",
                  id: "01FCNDV6P870EA6S7TK1DSYDG0",
                  name: "Customer Success",
                  slug: "customer-success"
                },
                custom_roles: [
                  %{
                    description: "Elevated permissions for the customer success team.",
                    id: "01FCNDV6P870EA6S7TK1DSYDG0",
                    name: "Customer Success",
                    slug: "customer-success"
                  }
                ],
                email: "lisa@incident.io",
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                name: "Lisa Karlin Curtis",
                role: "viewer",
                slack_user_id: "U02AYNF2XJM"
              }
            ]
          })
        )
      end)

      assert {200, %{pagination_meta: pagination_meta, users: users}, _} =
               list(@client,
                 email: "lisa@incident.io",
                 slack_user_id: "U12345678",
                 page_size: 10,
                 after: "01FDAG4SAP5TYPT98WGR2N7W91"
               )

      assert 10 == pagination_meta.page_size
      user = Enum.find(users, fn u -> u.email == "lisa@incident.io" end)
      assert "lisa@incident.io" == user.email
    end
  end

  describe "show/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            user: %{
              base_role: %{
                description: "Elevated permissions for the customer success team.",
                id: "01FCNDV6P870EA6S7TK1DSYDG0",
                name: "Customer Success",
                slug: "customer-success"
              },
              custom_roles: [
                %{
                  description: "Elevated permissions for the customer success team.",
                  id: "01FCNDV6P870EA6S7TK1DSYDG0",
                  name: "Customer Success",
                  slug: "customer-success"
                }
              ],
              email: "lisa@incident.io",
              id: "01FCNDV6P870EA6S7TK1DSYDG0",
              name: "Lisa Karlin Curtis",
              role: "viewer",
              slack_user_id: "U02AYNF2XJM"
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns expected response" do
      {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

      assert %{
               user: %{
                 base_role: %{
                   description: "Elevated permissions for the customer success team.",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Customer Success",
                   slug: "customer-success"
                 },
                 custom_roles: [
                   %{
                     description: "Elevated permissions for the customer success team.",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     name: "Customer Success",
                     slug: "customer-success"
                   }
                 ],
                 email: "lisa@incident.io",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 name: "Lisa Karlin Curtis",
                 role: "viewer",
                 slack_user_id: "U02AYNF2XJM"
               }
             } == response
    end
  end
end
