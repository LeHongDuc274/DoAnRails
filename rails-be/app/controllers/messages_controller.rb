class MessagesController < ApplicationController


	def requesting
		messages = Message.where("status = 0").order("created_at DESC")
		response = []
		messages.each { |e|
			user = e.user
			response <<{
				user_id: user.id,
				user_name: user.display_name,
				status: e.status,
				content: e.content,
				created_at: e.created_at
			}
		}

		render json: {
			status: true,
			data: response
		}

	end


	def create
		message = Message.new(user_id: @current_user.id , status: 0 , content: params[:content].to_s)

		if message.invalid?
			render json: {
				status: false,
				data: nil
			}, status: 401
		else 
			message.save
			render json: {
				status: true,
				data: message
			}
		end
	end


	def edit
		message = Message.find(params[:id])
		user_name = message.user.display_name
		message.update status: 1

		if message
			render json: {
				status: true,
				data: {
					user_name: user_name,
					status: message.status,
					content: message.content,
					created_at: message.created_at
				}
			}
		else
			render json: {
				status: false,
				data: nil
			}, status: 401
		end
	end

end