class Image < ApplicationRecord
  has_many :categories, through: :image_categories
  has_many :image_categories, dependent: :destroy
end
