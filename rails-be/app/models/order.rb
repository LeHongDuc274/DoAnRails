class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  after_save :broast_cast_message_channel

  @@FLAG_UPDATE_ORDER = "FLAG_UPDATE_ORDER"

  def broast_cast_message_channel
    #broast cast to Admin
    ActionCable.server.broadcast "message_channel" , @@FLAG_UPDATE_ORDER.as_json

    #broast cast to Table
    if self.status == 1
        ActionCable.server.broadcast "order_#{self.user_id}" , @@FLAG_UPDATE_ORDER
    end
  end

end
