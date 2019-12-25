class ConfirmationMailer < ApplicationMailer
  def confirmation_letter(email)
    mail to: email, subject: 'Activate account'
  end
end
