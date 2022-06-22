class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  after_save :broast_cast_message_channel

  @@FLAG_UPDATE_ORDER = "FLAG_UPDATE_ORDER"

  def broast_cast_message_channel
    ActionCable.server.broadcast "message_channel" , @@FLAG_UPDATE_ORDER.as_json
  end
end
