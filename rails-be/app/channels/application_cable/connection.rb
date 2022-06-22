module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user request.headers[:token]
      # logger.add_tags 'ActionCable', current_user.id
    end

    def find_verified_user token
      jwt_hash = ::JsonWebTokenLogic.decode(token)

      user = User.find_by(id: jwt_hash[:user_id])

      # return reject_unauthorized_connection if jwt_hash[:login_token] != user.login_token

      unless user.nil?
        return user
      else
        return reject_unauthorized_connection
      end
    end
  end
end
