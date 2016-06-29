class NotificationsMailer < ApplicationMailer
  default from: 'notification@flashcards.com'

  def pending_cards(user)
    @user = user
    mail(to: @user.email, subject: 'Not reviewed cards')
  end
end
