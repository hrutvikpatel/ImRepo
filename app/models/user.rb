class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :account
  has_many :orders

  after_save :create_account

  def create_account
    Account.create(:user => self, balance: 0)
  end

  def is_admin?
    false
  end
end
