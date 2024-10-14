class SessionsController < ApplicationController
  before_action :redirect_if_signed_in, only: %i[new create]
  before_action :require_authentication, only: :destroy
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

  def destroy
    sign_out
    redirect_to root_path, notice: "Bye! You've been logged out."
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
