defmodule IncidentIo.CustomFieldsV1Test do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import IncidentIo.CustomFieldsV1

  doctest IncidentIo.CustomFieldsV1

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/1" do
    test "returns expected HTTP status code" do
      use_cassette "custom_fields_v1#list" do
        assert {200, _, _} = list(@client)
      end
    end

    test "returns expected response" do
      use_cassette "custom_fields_v1#list" do
        {200, response, _} = list(@client)

        assert %{
                 custom_fields: [
                   %{
                     catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     created_at: "2021-08-17T13:28:57.801578Z",
                     description: "Which team is impacted by this issue",
                     field_type: "single_select",
                     id: "01FCNDV6P870EA6S7TK1DSYDG0",
                     name: "Affected Team",
                     options: [
                       %{
                         custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         id: "01FCNDV6P870EA6S7TK1DSYDG0",
                         sort_key: 10,
                         value: "Product"
                       }
                     ],
                     required: "never",
                     required_v2: "never",
                     show_before_closure: true,
                     show_before_creation: true,
                     show_before_update: true,
                     show_in_announcement_post: true,
                     updated_at: "2021-08-17T13:28:57.801578Z"
                   }
                 ]
               } == response
      end
    end
  end

  describe "create/2" do
    @body %{
      description: "Which team is impacted by this issue",
      field_type: "single_select",
      name: "Affected Team",
      required: "never",
      required_v2: "never",
      show_before_closure: true,
      show_before_creation: true,
      show_before_update: true,
      show_in_announcement_post: true
    }

    test "returns expected HTTP status code" do
      use_cassette "custom_fields_v1#create" do
        assert {201, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "custom_fields_v1#create" do
        {201, response, _} =
          create(@client, @body)

        assert %{
                 custom_field: %{
                   catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Which team is impacted by this issue",
                   field_type: "single_select",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Affected Team",
                   options: [
                     %{
                       custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       sort_key: 10,
                       value: "Product"
                     }
                   ],
                   required: "never",
                   required_v2: "never",
                   show_before_closure: true,
                   show_before_creation: true,
                   show_before_update: true,
                   show_in_announcement_post: true,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end

  describe "destroy/2" do
    test "returns expected HTTP status code" do
      use_cassette "custom_fields_v1#destroy" do
        assert {204, _, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "custom_fields_v1#destroy" do
        {204, response, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert nil == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "custom_fields_v1#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "custom_fields_v1#show" do
        {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 custom_field: %{
                   catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Which team is impacted by this issue",
                   field_type: "single_select",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Affected Team",
                   options: [
                     %{
                       custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       sort_key: 10,
                       value: "Product"
                     }
                   ],
                   required: "never",
                   required_v2: "never",
                   show_before_closure: true,
                   show_before_creation: true,
                   show_before_update: true,
                   show_in_announcement_post: true,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end

  describe "update/3" do
    @body %{
      description: "Which team is impacted by this issue",
      field_type: "single_select",
      name: "Affected Team",
      required: "never",
      required_v2: "never",
      show_before_closure: true,
      show_before_creation: true,
      show_before_update: true,
      show_in_announcement_post: true
    }

    test "returns expected HTTP status code" do
      use_cassette "custom_fields_v1#update" do
        assert {200, _, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)
      end
    end

    test "returns expected response" do
      use_cassette "custom_fields_v1#update" do
        {200, response, _} =
          update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)

        assert %{
                 custom_field: %{
                   catalog_type_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   created_at: "2021-08-17T13:28:57.801578Z",
                   description: "Which team is impacted by this issue",
                   field_type: "single_select",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   name: "Affected Team",
                   options: [
                     %{
                       custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       id: "01FCNDV6P870EA6S7TK1DSYDG0",
                       sort_key: 10,
                       value: "Product"
                     }
                   ],
                   required: "never",
                   required_v2: "never",
                   show_before_closure: true,
                   show_before_creation: true,
                   show_before_update: true,
                   show_in_announcement_post: true,
                   updated_at: "2021-08-17T13:28:57.801578Z"
                 }
               } == response
      end
    end
  end
end
