class UserMailer < ApplicationMailer
  def password_reset
    @user = params[:user]
    @password_reset_token = params[:password_reset_token]

    mail to: @user.email, subject: "Please reset your password"
  end
end
