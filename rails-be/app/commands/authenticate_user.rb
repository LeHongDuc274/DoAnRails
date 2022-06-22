class AuthenticateUser
	prepend SimpleCommand
	attr_accessor :login_id , :password, :current_user

def initialize(login_id, password)
	@login_id = login_id
	@password = password
end

def call
	if user 
		login_token = SecureRandom.hex
		user.update(login_token: login_token)
		@current_user = User.find_by(login_id: login_id)
		::JsonWebTokenLogic.encode(user_id: user.id, login_token: user.login_token)
	end
end

def user
	user = User.find_by(login_id: login_id)

	return user if user && user.authenticate(password)
	errors.add :user_authentication, "invalid credentials"
end

def current_user
	@current_user
	end
end