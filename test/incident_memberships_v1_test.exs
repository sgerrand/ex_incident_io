defmodule IncidentIo.IncidentMembershipsV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentMembershipsV1

  doctest IncidentIo.IncidentMembershipsV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "create/2" do
    @body %{
      incident_id: "01ET65M7ZADYFCKD4K1AE2QNMC",
      user_id: "01FCQSP07Z74QMMYPDDGQB9FTG"
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          201,
          Jason.encode!(%{
            incident_id: "01ET65M7ZADYFCKD4K1AE2QNMC",
            user_id: "01FCQSP07Z74QMMYPDDGQB9FTG"
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {201, _, _} = create(@client, @body)
    end

    test "returns expected response" do
      {201, response, _} = create(@client, @body)

      assert %{
               incident_id: "01ET65M7ZADYFCKD4K1AE2QNMC",
               user_id: "01FCQSP07Z74QMMYPDDGQB9FTG"
             } == response
    end
  end

  describe "revoke/2" do
    @body %{
      incident_id: "01ET65M7ZADYFCKD4K1AE2QNMC",
      user_id: "01FCQSP07Z74QMMYPDDGQB9FTG"
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 204, "")
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {204, _, _} = revoke(@client, @body)
    end

    test "returns expected response" do
      {204, response, _} = revoke(@client, @body)

      assert nil == response
    end
  end
end
