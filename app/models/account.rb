class Account < ApplicationRecord
  belongs_to :user
  has_many :orders
  attribute :balance, :default => 0
end
