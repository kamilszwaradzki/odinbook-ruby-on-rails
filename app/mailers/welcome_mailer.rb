class WelcomeMailer < ApplicationMailer
  default from: "no-reply@odinbook.example"
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Odinbook 👋")
  end
end
