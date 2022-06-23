class Category < ApplicationRecord
has_many :products
validates :name_type, presence: true
after_destroy :update_products

def update_products
  self.products.each do |pr|
    pr.update(status: -1)
  end
end


end
