class Message < ApplicationRecord
	belongs_to :user 

	after_update :broast_cast_update_message_channel
	after_create :broast_cast_new_message


	def broast_cast_update_message_channel
		data_message = []

		data_message << {
			"id": self.id,
			"user_id": self.user_id,
			"user_name": self.user.display_name,
			"status": 0,
			"content": self.content,
			"created_at": self.created_at.strftime("%I:%M %p")
		}
		message = {
			"type": "accept",
			"data": data_message
		}
		ActionCable.server.broadcast "message_channel" , JSON.generate(message)
	end

	def broast_cast_new_message
		data_message = []

		data_message << {
			"id": self.id,
			"user_id": self.user_id,
			"user_name": self.user.display_name,
			"status": self.status,
			"content": self.content,
			"created_at": self.created_at.strftime("%I:%M %p")
		}
		message = {
			"type": "create",
			"data": data_message
		}
		ActionCable.server.broadcast "message_channel" , JSON.generate(message)
	end

end
