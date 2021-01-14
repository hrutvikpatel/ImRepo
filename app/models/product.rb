class Product < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_one_attached :attachment, dependent: :destroy

  def self.search(search)
    if search
      Product.where('title LIKE :search OR description LIKE :search', search: "%#{search}%")
    else
      Product.all
    end
  end

end
