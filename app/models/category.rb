class Category < ApplicationRecord
  has_many :image_categories
  has_many :images, through: :image_categories

  def name=(s)
    write_attribute(:name, s.to_s.titleize)
  end
end
