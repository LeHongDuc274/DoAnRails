class OrderDetailChannel < ApplicationCable::Channel
  def subscribed
    # stop_all_streams
    # Order.where(user_id: current_user.id).find_each do |conversation|
      stream_from "order_detail"
  end

  def unsubscribed
    stop_all_streams
  end

end