module Authentication
  def require_authentication
    restore_authentication || request_authentication
  end

  def restore_authentication
    Current.user = User.find_by(id: cookies[:user_id])
  end

  def request_authentication
    redirect_to new_session_path, notice: "Sign in first"
  end

  def sign_in(user)
    # Signin logic
    cookies.permanent[:user_id] = user.id
  end
end
