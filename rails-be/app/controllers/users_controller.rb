class UsersController < ApplicationController

before_action :can_modify_user?


def index
users = User.all
	if users 
		render json: {
			status: true,
			data: users
		}
	else 
		render json: {
			status: false,
			data: users.errors.full_messages
		}, status: 401
	end
end


def tables
	users = User.where(	role: 3 , status: 0).order(created_at: :desc)
	if users
		render json: {
			status: true,
			data: users
		}
	else 
		render json: {
			status: false,
			data: []
		}
	end
end

def create
	user = User.new(
		login_id: params[:login_id],
		display_name: params[:display_name],
		role: params[:role],
		status: params[:status],
		password: params[:password],
		password_confirmation: params[:password_confirmation]
		)
	if user.invalid?
		render json: {
			status: false,
			data: {

			},
			errors_messages: user.errors.full_messages
		}
	else 
		user.save
		render json:{
			status: true,
			data: user
		}

	end	

end


def edit
	user = User.find params[:id]

	update_params.each do |k ,v|
		if !user.update(k => v)
			render json: {
				status: false,
				data: user.errors.full_messages
			}, status: 404
			return
		end

	end

	if user
		render json: {
			status: true,
			data: user
		}
	else
		render json: {
			status: false,
			data: {

			}
		}, status: :not_found
	end

end

def delete
	user = User.find params[:id]
	if !user || user.role == 0
		render json: {
			status: false,
			data: "can't find this user"
		}, status: 401
		return
	end
	if user.destroy
		render json: {
			status: true,
			data: user.login_id
		}

	else
		render json: {
			status: false,
			data: "can't delete Admin"
		}, status: 401

	end

end

def get_ordering_by_table
	order = Order.where("user_id = ? AND status = ?", params[:user_id], 0).first

	if order
		order_details = order.order_details
		user = order.user

		render json: {
			status: true,
			user_name: user.display_name,
			order: order,
			data: order_details
		}
	else
		render json: {
			status: false,
			data: ''
		}, status: 404
	end
	
end

def get_all_ordering
	orders = Order.where("status = ?" , 0)
	if orders
		datas = Array.new
		orders.each do |order|
			details = order.order_details
			user = order.user
			item = OrderResponse.new(user , order , details)
			datas << item
		end
		render json: {
			status: true,
			count: orders.size,
			data: datas
		}
	end
end


private

def update_params
	params.permit(:display_name, :password, :password_confirmation , :role , :status)

end

end