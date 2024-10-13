class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate_by(session_params)
      # Signin logic
      sign_in user
      redirect_to dashboard_path, notice: "Logged in with #{user.email}"
    else
      flash.now[:notice] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
