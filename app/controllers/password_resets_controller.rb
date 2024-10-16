class PasswordResetsController < ApplicationController
  def new
  end

  def create
    if user = User.find_by(email: params[:email])
      # 1. Unique token generation
      token = user.generate_token_for(:password_reset)

      # 2. Deliver the token via email
      UserMailer.with(user: user, password_reset_token: token).password_reset.deliver_later

      redirect_to root_path, notice: "A recovery email is on its way! Check your inbox."
    else
      flash.now[:notice] = "No user found with that email address."
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    user = User.find_by_token(:password_reset, params[:password_reset_token])

    if user.nil?
      flash[:notice] = "Invalid token. Try again requesting a new password reset link."
      redirect_to new_password_reset_path
    elseif user.update(password_reset_params)
      sign_in user
      redirect_to dashboard_path, notice: "Password successfully updated!"
    else
      flash.now[:notice] = user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_reset_params
    params.require(:password_reset).permit(:password, :password_confirmation)
  end
end
