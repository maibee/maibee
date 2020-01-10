class RecordsController < ApplicationController
  def zeroing
    current_user.update(unread: 0)
  end
end
