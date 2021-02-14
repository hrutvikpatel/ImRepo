class AccountController < ApplicationController
  before_action :authenticate_user!

  def show
    @account = Account.find_by(user_id: params[:user_id])
  end

  def update
    @account = Account.find_by(user_id: params[:user_id])
    response = @account.update(balance: params[:balance])

    if response
      flash[:notice] = 'Updated account balance!'
    else
      flash[:alert] = 'Failed to update account balance!'
    end

    redirect_to user_account_path(current_user.id)
  end
end
