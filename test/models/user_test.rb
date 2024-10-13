require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "password must be at least 8 characters" do
    invalid_password = "a" * (User::MINIMUM_PASSWORD_LENGTH - 1)
    user = User.new email: "[email protected]", password: invalid_password

    assert_not user.valid?
    assert_includes user.errors.full_messages, "Password is too short (minimum is #{User::MINIMUM_PASSWORD_LENGTH} characters)"
  end

  test "password must be present" do
    user = User.new email: "[email protected]", password: ""

    assert_not user.valid?
    assert_includes user.errors.full_messages, "Password can't be blank"
  end

  test "email uniqueness" do
    user = users(:simon).dup
    user.email = "  #{user.email.upcase}  "
    user.password = "password"

    assert_not user.valid?
    assert_equal ["has already been taken"], user.errors[:email]
  end
end
