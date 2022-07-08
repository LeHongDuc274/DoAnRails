class ApplicationController < ActionController::API
  before_action :authenticate_request
  before_action :default_response

  def authenticate_request
    authorize_api_request = AuthorizeApiRequest.new(request.headers)
    authentize_api_request_new = authorize_api_request.call
    @current_user = authentize_api_request_new.result
    render json: { errors: "Note Authorized" }, status: 401 unless @current_user
  end

  def can_modify_user?
    if !@current_user.is_admin?
      render json: {
        status: false,
        data: "isn't admin"
      }, status: 401
    end
    @current_user.is_admin?
  end

  def render_json(data = nil)
    render json: { status: @status, data: data }, status: @http_status
  end

  def default_response
    @status = true
    @http_status = 200
  end

  def order_details_response detail
    {
      "id": detail.id,
      "user_id": detail.user_id,
      "order_id": detail.order_id,
      "product_id": detail.product_id,
      "amount": detail.amount,
      "note": detail.note,
      "status": detail.status,
      "total_price": detail.total_price,
      "user_display_name": detail.user.display_name,
      "created_at": detail.created_at&.strftime("%I:%M %p")
    }
  end

end
