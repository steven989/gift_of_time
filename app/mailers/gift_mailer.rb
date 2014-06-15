class GiftMailer < ActionMailer::Base
  default from: "steven989@gmail.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Gift of Time!")
  end

end
