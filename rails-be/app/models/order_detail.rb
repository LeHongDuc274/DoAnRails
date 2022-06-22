class OrderDetail < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :order
  # validate :valid_status , on: :update
  after_save :broad_cast_change_status

  validate :amount , :valid_count

  #status : 0-> pending , 1 -> preparing , 2 -> complete , 3 -> delivering , 4 -> delivered 

  @@FLAG_UPDATE_ORDER_DETAIL_TO_KITCHEN = "FLAG_UPDATE_ORDER_DETAIL_TO_KITCHEN"
  @@FLAG_UPDATE_ORDER_DETAIL_TO_USER = "FLAG_UPDATE_ORDER_DETAIL_TO_USER"

  def valid_count
    errors.add(:amount , " <=0 ") if self.amount <= 0
  end

  def valid_status
    errors.add(:status , "this  item was preparing") if self.status >= 1
  end

# ban1 - dki order_1 -> 
  def broad_cast_change_status
    # to_kitchen, admin
    ActionCable.server.broadcast "order_detail" , @@FLAG_UPDATE_ORDER_DETAIL_TO_KITCHEN.as_json
    
    # to table-user
    user_id = self.user_id
    ActionCable.server.broadcast "order_#{user_id}" , @@FLAG_UPDATE_ORDER_DETAIL_TO_USER.as_json
  end

end
