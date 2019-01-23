class UserMailer < ApplicationMailer
  def generate_password(user, password)
    @user = user
    @password = password
    mail to: user.email, subject: "Generate password"
  end
end
