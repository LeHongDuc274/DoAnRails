class Product < ApplicationRecord
  belongs_to :category , optional: true
  has_one_attached :image
end
