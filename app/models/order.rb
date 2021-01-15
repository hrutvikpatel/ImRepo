class Order < ApplicationRecord
  belongs_to :account
  belongs_to :user
  has_one :products
end
