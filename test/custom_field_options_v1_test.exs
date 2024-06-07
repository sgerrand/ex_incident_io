defmodule IncidentIo.CustomFieldOptionsV1Test do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import IncidentIo.CustomFieldOptionsV1

  doctest IncidentIo.CustomFieldOptionsV1

  @client IncidentIo.Client.new(%{api_key: "yourtokengoeshere"})

  describe "list/3" do
    test "returns expected HTTP status code" do
      use_cassette "custom_field_options_v1#list" do
        assert {200, _, _} = list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "custom_field_options_v1#list" do
        {200, %{custom_field_options: custom_field_options, pagination_meta: _}, _} =
          list(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert [
                 %{
                   custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   sort_key: 10,
                   value: "Product"
                 }
               ] == custom_field_options
      end
    end
  end

  describe "create/2" do
    @body %{
      custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
      sort_key: 10,
      value: "Product"
    }

    test "returns expected HTTP status code" do
      use_cassette "custom_field_options_v1#create" do
        assert {201, _, _} = create(@client, @body)
      end
    end

    test "returns expected response" do
      use_cassette "custom_field_options_v1#create" do
        {201, %{custom_field_option: custom_field_option}, _} =
          create(@client, @body)

        assert %{
                 custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 sort_key: 10,
                 value: "Product"
               } == custom_field_option
      end
    end
  end

  describe "destroy/2" do
    test "returns expected HTTP status code" do
      use_cassette "custom_field_options_v1#destroy" do
        assert {204, _, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "custom_field_options_v1#destroy" do
        {204, response, _} = destroy(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert nil == response
      end
    end
  end

  describe "show/2" do
    test "returns expected HTTP status code" do
      use_cassette "custom_field_options_v1#show" do
        assert {200, _, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")
      end
    end

    test "returns expected response" do
      use_cassette "custom_field_options_v1#show" do
        {200, response, _} = show(@client, "01FCNDV6P870EA6S7TK1DSYDG0")

        assert %{
                 custom_field_option: %{
                   custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   id: "01FCNDV6P870EA6S7TK1DSYDG0",
                   sort_key: 10,
                   value: "Product"
                 }
               } == response
      end
    end
  end

  describe "update/3" do
    @body %{
      sort_key: 10,
      value: "Product"
    }

    test "returns expected HTTP status code" do
      use_cassette "custom_field_options_v1#update" do
        assert {200, _, _} = update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)
      end
    end

    test "returns expected response" do
      use_cassette "custom_field_options_v1#update" do
        {200, %{custom_field_option: custom_field_option}, _} =
          update(@client, "01FCNDV6P870EA6S7TK1DSYDG0", @body)

        assert %{
                 custom_field_id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 id: "01FCNDV6P870EA6S7TK1DSYDG0",
                 sort_key: 10,
                 value: "Product"
               } == custom_field_option
      end
    end
  end
end
