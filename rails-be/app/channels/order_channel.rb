class OrderChannel < ApplicationCable::Channel
  def subscribed
    id = params[:user_id]
    stream_from "order_#{id}"
  end

  def unsubscribed
    stop_all_streams
  end

end