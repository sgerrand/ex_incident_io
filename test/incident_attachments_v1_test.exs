defmodule IncidentIo.IncidentAttachmentsV1Test do
  use IncidentIo.TestCase, async: true
  import IncidentIo.IncidentAttachmentsV1

  doctest IncidentIo.IncidentAttachmentsV1

  @client IncidentIo.Client.new(%{api_key: "yourApiKeyGoesHere"})

  describe "list/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            incident_attachments: [
              %{
                id: "01FCNDV6P870EA6S7TK1DSYD5H",
                incident_id: "01FCNDV6P870EA6S7TK1DSYD5H",
                resource: %{
                  external_id: "123",
                  permalink: "https://my.pagerduty.com/incidents/ABC",
                  resource_type: "pager_duty_incident",
                  title: "The database has gone down"
                }
              }
            ]
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
    end

    test "returns expected response" do
      {200, response, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

      assert %{
               incident_attachments: [
                 %{
                   id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   incident_id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   resource: %{
                     external_id: "123",
                     permalink: "https://my.pagerduty.com/incidents/ABC",
                     resource_type: "pager_duty_incident",
                     title: "The database has gone down"
                   }
                 }
               ]
             } == response
    end
  end

  describe "list/4" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          200,
          Jason.encode!(%{
            incident_attachments: [
              %{
                id: "01FCNDV6P870EA6S7TK1DSYD5H",
                incident_id: "01FCNDV6P870EA6S7TK1DSYD5H",
                resource: %{
                  external_id: "123",
                  permalink: "https://my.pagerduty.com/incidents/ABC",
                  resource_type: "pager_duty_incident",
                  title: "The database has gone down"
                }
              }
            ]
          })
        )
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {200, _, _} = list(@client, nil, "123", :pager_duty_incident)
    end

    test "returns expected response" do
      {200, response, _} = list(@client, nil, "123", :pager_duty_incident)

      assert %{
               incident_attachments: [
                 %{
                   id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   incident_id: "01FCNDV6P870EA6S7TK1DSYD5H",
                   resource: %{
                     external_id: "123",
                     permalink: "https://my.pagerduty.com/incidents/ABC",
                     resource_type: "pager_duty_incident",
                     title: "The database has gone down"
                   }
                 }
               ]
             } == response
    end
  end

  describe "list: error cases" do
    test "raises when not provided incident_id or external_id" do
      assert_raise RuntimeError,
                   "Error: only provide an incident_id *or* external_id and resource_type – not both.",
                   fn ->
                     list(@client)
                   end
    end

    test "raises when provided both incident_id and external_id" do
      assert_raise RuntimeError,
                   "Error: only provide an incident_id *or* external_id and resource_type – not both.",
                   fn ->
                     list(@client, "01FCNDV6P870EA6S7TK1DSYD5H", "123")
                   end
    end

    test "raises when provided both incident_id and external_id and resource_type" do
      assert_raise RuntimeError,
                   "Error: only provide an incident_id *or* external_id and resource_type – not both.",
                   fn ->
                     list(@client, "01FCNDV6P870EA6S7TK1DSYD5H", "123", :pager_duty_incident)
                   end
    end

    test "raises when provided external_id without resource_type" do
      assert_raise RuntimeError,
                   "Error: only provide an incident_id *or* external_id and resource_type – not both.",
                   fn ->
                     list(@client, nil, "123")
                   end
    end
  end

  describe "create/2" do
    @body %{
      incident_id: "01FDAG4SAP5TYPT98WGR2N7W91",
      resource: %{
        external_id: "123",
        resource_type: "pager_duty_incident"
      }
    }

    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(
          conn,
          201,
          Jason.encode!(%{
            incident_attachment: %{
              id: "01FCNDV6P870EA6S7TK1DSYD5H",
              incident_id: "01FCNDV6P870EA6S7TK1DSYD5H",
              resource: %{
                external_id: "123",
                permalink: "https://my.pagerduty.com/incidents/ABC",
                resource_type: "pager_duty_incident",
                title: "The database has gone down"
              }
            }
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
               incident_attachment: %{
                 id: "01FCNDV6P870EA6S7TK1DSYD5H",
                 incident_id: "01FCNDV6P870EA6S7TK1DSYD5H",
                 resource: %{
                   external_id: "123",
                   permalink: "https://my.pagerduty.com/incidents/ABC",
                   resource_type: "pager_duty_incident",
                   title: "The database has gone down"
                 }
               }
             } == response
    end
  end

  describe "delete/2" do
    setup do
      Req.Test.stub(:incident_io, fn conn ->
        Plug.Conn.send_resp(conn, 204, "")
      end)

      :ok
    end

    test "returns expected HTTP status code" do
      assert {204, _, _} = destroy(@client, "01FDAG4SAP5TYPT98WGR2N7W91")
    end

    test "returns expected response" do
      {204, response, _} = destroy(@client, "01FDAG4SAP5TYPT98WGR2N7W91")

      assert nil == response
    end
  end
end
