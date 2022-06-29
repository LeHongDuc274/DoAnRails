class OrderDetailsController < ApplicationController



  def index

  end

  def create
    order_detail = OrderDetail.new( user_id: @current_user.id, product_id: params[:product_id],
      order_id: params[:order_id], amount: params[:amount], note: params[:note],
      status: 0 )

    if order_detail.invalid?
    # binding.pry
    render json: {
      status: false,
      data: order_detail.errors.full_messages
    }, status: 404
  else
    order_detail.save
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
      data: "This item was prepared"
    }, 
    status: 404
    return
  end

  # update_params.each do |k ,v|
  detail =  OrderDetail.update(params[:id],update_params)
  if detail.errors.present?
    render json: {
     status: false,
     data: order_detail.errors.full_messages
   }, status: 404

 else
  render json: {
    status: true,
    data: detail
  }
end


  # if order_detail
  #   render json: {
  #     status: true,
  #     data: order_detail
  #   }
  #   else
  #   render json: {
  #     status: false,
  #     data: {

  #     }
  #   }, status: :not_found
  # end

end

def delete
  order_detail = OrderDetail.find params[:id]
  if order_detail && order_detail.destroy
    render json: {
      status: true,
      data: order_detail
    }
  else 
    render json: {
      status: false,
      data: order_detail.errors.full_messages
    }, status: 404
  end
end

def ordering
  details = OrderDetail.where("status < 4").order("created_at DESC")
  response = []
  details.each{ |detail| 
    response << {
      id: detail.id,
      user_id: detail.user_id,
      order_id: detail.order_id,
      product_id: detail.product_id,
      amount: detail.amount,
      note: detail.note,
      status: detail.status,
      user_display_name: detail.user.display_name
    }
  }
  render json: {
    status: true,
    data: response
  } 
end

private 

def update_params
  params.permit(:amount, :note , :status)
end


end