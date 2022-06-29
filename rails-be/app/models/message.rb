class Message < ApplicationRecord
	belongs_to :user 

	after_save :broast_cast_to_message_channel
	after_create :broast_cast_new_message

	@@FLAG_UPDATE_MESSAGE = "FLAG_UPDATE_MESSAGE" 
	@@FLAG_NEW_MESSAGE = "FLAG_NEW_MESSAGE"

	def broast_cast_to_message_channel
		ActionCable.server.broadcast "message_channel" , @@FLAG_UPDATE_MESSAGE.as_json
	end

	def broast_cast_new_message
		ActionCable.server.broadcast "message_channel" , @@FLAG_NEW_MESSAGE.as_json
	end

end
