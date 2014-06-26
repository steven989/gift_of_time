class GiftMailer < ActionMailer::Base
  default from: "steven989@gmail.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Gift of Time!")
  end

  def next_step_email(user, gift)
    @user = user
    @gift = gift
    mail(to: @user.email, subject: "Gift #{@gift.gift_comp_id} to #{@gift.recipient_name} has been created!")
  end

end
