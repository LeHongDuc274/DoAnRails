class Product < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :category , optional: true

  has_many :order_details
  has_one_attached :image
  after_save :broad_cast_product_channel

  FLAG_CHANGE_PRODUCT = "FLAG_CHANGE_PRODUCT"

  def broad_cast_product_channel
    data = {
      "id": self.id,
      "category_id": self.category_id,
      "name": self.name,
      "content": self.content,
      "status": self.status,
      "price": self.price,
      "image_url": rails_blob_path(self.image, disposition: "attachment", only_path: true)
    }
    ActionCable.server.broadcast "product_channel" , JSON.generate(data)
    
    if self.status == 1
      details = self.order_details.where("order_details.status = 0")
      details.each { |detail|
        detail.destroy
        data_message = []
        data_message << {
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
        message = {
          "type": "delete",
          "data": data_message
        }
        ActionCable.server.broadcast "order_detail", JSON.generate(message)
      }
    end
  end

end
