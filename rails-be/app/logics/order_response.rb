class OrderResponse

attr_accessor :user_name , :order_id, :order_details
def initialize(user, order, order_details)
	@user_name = user.display_name
	@order_id = order.id
	@order_details = order_details
end

end