class RemoveChannel < ApplicationCable::Channel
  def subscribed
    stream_from "remove_channel"
  end
end
