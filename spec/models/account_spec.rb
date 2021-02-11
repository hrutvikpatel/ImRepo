require 'rails_helper'

RSpec.describe Account, :type => :model do
  context "is valid" do
    it "with default balance" do
      user = create(:user)
      account = Account.new(:user => user)
      expect(account).to be_valid
      expect(account.balance).eql?(0.0)
    end

    it "with set balance" do
      user = create(:user)
      account = Account.new(:user => user, :balance => 10)
      expect(account).to be_valid
      expect(account.balance).eql?(10.0)
    end
  end

  context "is not valid" do
    it "with no user" do
      expect(Account.new).to_not be_valid
    end
  end
 end
