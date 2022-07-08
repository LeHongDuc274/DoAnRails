class OrderDetail < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :order
  # validate :valid_status , on: :update
  after_save :broad_cast_change
  after_destroy :broad_cast_change

  validate :amount , :valid_count

  #status : 0-> pending , 1 -> preparing , 2 -> complete , 3 -> delivering , 4 -> delivered 


  def valid_count
    errors.add(:amount , " <=0 ") if self.amount <= 0
  end

  def valid_status
    errors.add(:status , "this  item was preparing") if self.status >= 1
  end

# ban1 - dki order_1 -> 

  def broad_cast_change
    ActionCable.server.broadcast "order_#{self.user_id}" , self.user_id.to_s
  end

end
