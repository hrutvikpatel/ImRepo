class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, presence: true, uniqueness: true

  def name=(s)
    write_attribute(:name, s.to_s.titleize)
  end

  def self.search(search)
    if search
      Category.where('name LIKE :search', search: "%#{search}%")
    else
      Category.all
    end
  end
end
