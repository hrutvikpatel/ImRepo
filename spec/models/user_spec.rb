require 'rails_helper'

RSpec.describe User, type: :model do
  context 'create new user' do
    before(:each) do
      @user = create(:user)
    end

    context 'account' do
      it 'should be created' do
        expect(@user.account).to be_present
      end

      it 'should have default balance of 0.0' do
        expect(@user.account.balance).to eq(0.0)
      end
    end
  end
end
