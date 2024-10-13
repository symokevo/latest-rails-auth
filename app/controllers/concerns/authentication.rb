module Authentication
  def require_authentication
    restore_authentication || request_authentication
  end

  def request_authentication
    redirect_to new_session_path, notice: "You need to sign in first"
  end

  def restore_authentication
    if session = session_form_cookies
      Current.user = session.user
    end
  end

  def sign_in(user)
    session = user.sessions.create!
    cookies.signed.permanent[:session_id] = {value: user.id, httpoly: true}
  end

  def session_form_cookies
    Session.find_by(id: cookies.signed[:session_id])
  end
end
