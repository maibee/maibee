class RecordsController < ApplicationController
  def update
    current_user.update(unread: 0)
  end
end
