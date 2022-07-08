class ProductChannel < ApplicationCable::Channel

def subscribed
    # stop_all_streams
    # Order.where(user_id: current_user.id).find_each do |conversation|
      stream_from "product_channel"
  end

  def unsubscribed
    stop_all_streams
  end

end