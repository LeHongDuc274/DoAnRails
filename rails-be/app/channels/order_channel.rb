class OrderChannel < ApplicationCable::Channel
  def subscribed
    # stop_all_streams
    # Order.where(user_id: current_user.id).find_each do |conversation|
      stop_all_streams
      id = params[:user_id]
      stream_from "order_#{id}"
  end

  def unsubscribed
    stop_all_streams
  end

end