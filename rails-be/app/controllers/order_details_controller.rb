class OrderDetailsController < ApplicationController

  def index

  end

  def create
    order_detail = OrderDetail.new( user_id: @current_user.id, product_id: params[:product_id],
      order_id: params[:order_id], amount: params[:amount], note: params[:note], total_price: params[:total_price],
      status: 0 )

    if Product.find_by(id: params[:product_id]).status == 1
      return render json: {
        status: false,
        message: "Lỗi : Không tạo được item"
      }
    end

    if order_detail.invalid?
      render json: {
        status: false,
        message: order_detail.errors.full_messages
      }
    else
      order_detail.save
      data_message = []
      data_message << order_details_response(order_detail)

      message = {
        "type": "create",
        "data": data_message
      }
      ActionCable.server.broadcast "order_detail", JSON.generate(message)
      render json: {
        status: true,
        data: order_detail
      }
    end
  end

  def update
    order_detail = OrderDetail.find params[:id]
    if order_detail.status >= 1 && @current_user.role == 3
      render json: {
        status: false,
        data: "Lỗi: Sản phẩm đang được chuẩn bị"
      }
      return
    end

  # update_params.each do |k ,v|
  if order_detail.product.status == 1 && @current_user.role == 3
    return render json: {
      status: false,
      message: 'Sản phẩm này đã hết'
    }
  end

  detail =  OrderDetail.update(params[:id],update_params)
  if detail.errors.present?
    render json: {
     status: false,
     mesage: order_detail.errors.full_messages
   }

 else
   data_message = []
   data_message << order_details_response(detail)
   message = {
    "type": "update",
    "data": data_message
  }
  ActionCable.server.broadcast "order_detail", JSON.generate(message)
  render json: {
    status: true,
    data: detail
  }
end
end

def delete
  order_detail = OrderDetail.find params[:id]
  if order_detail && order_detail.status < 1 && order_detail.destroy
   data_message = []
   data_message << order_details_response(order_detail)
   message = {
    "type": "delete",
    "data": data_message
  }
  ActionCable.server.broadcast "order_detail", JSON.generate(message)
    render json: {
      status: true,
      data: nil  
    }
  else 
    render json: {
      status: false,
      message: order_detail.errors.full_messages
    }
  end
end

def ordering
  details = OrderDetail.eager_load(:user)
  .where("order_details.status < 4").order(created_at: :asc)
    # AND order_details.created_at > ?", Time.now.beginning_of_day)
  
  response = []
  details.each{ |detail| 
    response << order_details_response(detail)
  }
  render json: {
    status: true,
    data: response
  } 
end

private 

def update_params
  params.permit(:amount, :note , :status, :total_price)
end


end