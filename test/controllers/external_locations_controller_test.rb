require 'test_helper'

class ExternalLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @external_location = external_locations(:one)
  end

  test "should get index" do
    get external_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_external_location_url
    assert_response :success
  end

  test "should create external_location" do
    assert_difference('ExternalLocation.count') do
      post external_locations_url, params: { external_location: { address: @external_location.address, description: @external_location.description, name: @external_location.name } }
    end

    assert_redirected_to external_location_url(ExternalLocation.last)
  end

  test "should show external_location" do
    get external_location_url(@external_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_external_location_url(@external_location)
    assert_response :success
  end

  test "should update external_location" do
    patch external_location_url(@external_location), params: { external_location: { address: @external_location.address, description: @external_location.description, name: @external_location.name } }
    assert_redirected_to external_location_url(@external_location)
  end

  test "should destroy external_location" do
    assert_difference('ExternalLocation.count', -1) do
      delete external_location_url(@external_location)
    end

    assert_redirected_to external_locations_url
  end
end
