require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    sign_in users(:simon)
    get dashboard_path
    assert_response :success
  end
end
