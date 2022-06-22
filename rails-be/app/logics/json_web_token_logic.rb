class JsonWebTokenLogic

	def self.encode(payload, exp = 1.years.from_now)
		payload[:exp] = exp.to_i
		JWT.encode(payload, Rails.application.secrets.secret_key_base)
	end

	def self.decode(token)
		HashWithIndifferentAccess.new JWT.decode(token,Rails.application.secrets.secret_key_base)[0]
	rescue
		nil
	end

end