class AuthorizeApiRequest
	prepend SimpleCommand

def initialize (headers = {})
	@headers = headers
end

def call
	user
end

private

attr_reader :headers

def user
	if decode_auth_token
		current_user =  User.where(id: decode_auth_token[:user_id].to_i).first

		if current_user&& current_user.login_token == decode_auth_token[:login_token]
			@user = current_user
		else
			@user || errors.add(:token, "invalid") && nil

		end
	end
	@user
end


def decode_auth_token
	 ::JsonWebTokenLogic.decode(http_auth_header)
end

def http_auth_header
	if headers['Authorization'].present?
		return headers['Authorization'].split(' ').last
	else 
		errors.add :token , 'missing token'
	end
end


end