defmodule IncidentIo.IdentityV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IdentityV1

  doctest IncidentIo.IdentityV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "show/1" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            identity: %{
              dashboard_url: "https://app.incident.io/my-org",
              name: "Alertmanager token",
              roles: [
                "incident_creator"
              ]
            }
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = show(@client)
    end

    test "returns expected response" do
      {200, response, _} = show(@client)

      assert %{
               identity: %{
                 dashboard_url: "https://app.incident.io/my-org",
                 name: "Alertmanager token",
                 roles: [
                   "incident_creator"
                 ]
               }
             } == response
    end
  end
end
