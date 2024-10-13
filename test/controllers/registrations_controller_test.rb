require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest

  # Test that the path is correct
  test "#new" do
  get new_registration_path

  assert_response :success
  end

  # Test the Create action
  test "#create" do
  assert_difference "User.count", 1 do
    post registration_path, params: { user: { email: "[email protected]", password: "password" } }
  end

  assert_redirected_to dashboard_path
  end
end
