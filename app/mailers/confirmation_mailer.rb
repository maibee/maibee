class ConfirmationMailer < ApplicationMailer

  def confirmation_letter(user)
    @user = user
    @url = '#'
    mail to: 'user.email', subject: 'Activate account'
  end
end
