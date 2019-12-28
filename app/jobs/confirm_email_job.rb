class ConfirmEmailJob < ApplicationJob
  queue_as :default

  def perform(current_user)
    # Do something later
    ConfirmationMailer.confirmation_letter(current_user).deliver
  end
end
