class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, presence: true, uniqueness: true

  def name=(s)
    write_attribute(:name, s.to_s.titleize)
  end
end
