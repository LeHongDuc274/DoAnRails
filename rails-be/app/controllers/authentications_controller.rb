class AuthenticationsController < ApplicationController

skip_before_action :authenticate_request

def authenticate
	authenticate_user_new = AuthenticateUser.new(params[:login_id], params[:password])
	authenticate_user = authenticate_user_new.call
	current_user = authenticate_user_new.current_user
	if authenticate_user.success?
		render json: {
			status: true,
			data: {
				id: current_user.id,
				login_id: current_user.login_id,
				display_name: current_user.display_name,
				access_token: authenticate_user.result,
				status: current_user.status,
				role: current_user.role
			}
		}
	else
		render json: {
			status: false,
			data: {
				
			}
		},
		status: :unauthorized
	end
end

end