class OrdersController < ApplicationController


  def index
   orders = Category.all
   if orders
    render json: {
     status: true,
     data: orders
   }
 else
  render json: {
   status: false,
   data: orders.errors.full_messages
 }, status: 404
end
end

def ordering
	orderings = []
	tables = User.eager_load(:orders).where("users.role = 3 AND users.status = 0")

	unless tables.present? 
   render json: {
    status: false,
    data: []
  }, status: 404
  return
end

tables.each{ |table|
  orderings <<	{
   display_name: table.display_name,
   user_id: table.id,
   order: table.orders.last
 }
}

render json: {
  status: true,
  data: orderings
}

end

def create_order_with_order_details 
	order = Order.new(
		user_id: @current_user.id,
		status: 0,
		total_price: 0
   )

	if order.invalid?
		@status = false
		@http_status = 404
		render_json(order.errors.full_messages)
	else
    ActiveRecord::Base.transaction do
  		order.save
  		creat_instance_order_details(order)
    end

		if @errors.present?
			render json: {
				status: false,
				data: @errors
			}, status: 404 , errors: @errors
			return
		end


		OrderDetail.import @order_details_new
    data_message = []
    order.order_details.each do |detail|
      data_message << order_details_response(detail)
    end

    message = {
      "type": "create",
      "data": data_message
    }

    ActionCable.server.broadcast "order_detail", JSON.generate(message)
    render json: {
     status: true,
     data: {
        id: order.id,
        status: order.status,
        user_id: order.user_id,
        total_price: order.total_price,
        order_details: order.order_details
      }
    }
  end
end

def creat_instance_order_details order #moi element co user_id, chua co order_id
	order_details_params = params[:order_details]
	@order_details_new = order_details_params.map { |e|
		OrderDetail.new( user_id: @current_user.id, product_id: e[:product_id],
      order_id: order.id, amount: e[:amount], note: e[:note], total_price: e[:total_price],
		status: 0 ) #status = pending
  }
  @errors = []
  @order_details_new.each do |order_detail|
    if order_detail.invalid? 
      @errors << order_detail.errors.full_messages
    end
    product = Product.find_by(id: order_detail[:product_id])
    if (product.status == 1)
      @errors << "#{product.name} da het hang"
    end
  end
end

def order
	user_id = params[:user_id].to_i
	user = User.find user_id

	if user.nil?
		render json: {
			status: false,
			data: nil
		}, status: :unauthorized
		return
	end

	order_res = user.orders.where("status = 0").first

	if order_res.nil?
		render json: {
			status: false,
			data: nil
		}
	else
   render json: {
    status: true,
    data: {
     id: order_res.id,
     status: order_res.status,
     user_id: order_res.user_id,
     total_price: order_res.total_price,
     order_details: order_res.order_details
   }
 }		
end
end

def complete
	user_id = params[:user_id]
	user = User.find user_id
	if user.nil?
		render json: {
			status: false,
			data: nil
		}, status: 404
		return
	end
	order = user.orders.last
  total_price = order.order_details.sum("total_price")
  order.update(status: 1 , total_price: total_price)
  if order.invalid?
    render json: {
     status: false,
     data: nil
   }, status: 404
 else
  render json: {
   status: true,
   data: nil
 }
end

end


end