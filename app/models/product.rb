class Product < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_one_attached :image, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true
  validates :categories, :length => { :minimum => 1, :message => "not selected (at least one)" }


  def self.search(search)
    if search
      Product.where('title LIKE :search OR description LIKE :search', search: "%#{search}%")
    else
      Product.all.includes(image_attachment: :blob)
    end
  end

end
