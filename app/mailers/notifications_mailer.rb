class NotificationsMailer < ApplicationMailer
  def pending_cards(user)
    @user = user
    mail(to: @user.email, subject: 'Not reviewed cards')
  end
end
