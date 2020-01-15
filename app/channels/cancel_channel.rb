class CancelChannel < ApplicationCable::Channel
  def subscribed
    stream_from "cancel_channel"
  end
end
