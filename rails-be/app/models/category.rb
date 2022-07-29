class Category < ApplicationRecord
has_many :products
validates :name_type, presence: true
after_destroy :update_products
after_save :broad_cast_product_channel

def broad_cast_product_channel
    # ActionCable.server.broadcast "product_channel" , FLAG_CHANGE_PRODUCT.as_json
end

end
