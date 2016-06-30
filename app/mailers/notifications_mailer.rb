class NotificationsMailer < ApplicationMailer
  default from: 'notification@my-project-edx-shurikovich.c9users.io'

  def pending_cards(user)
    @user = user
    mail(to: @user.email, subject: 'Not reviewed cards')
  end
end
