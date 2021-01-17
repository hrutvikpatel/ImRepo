class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(:user_id => params[:user_id]).order("created_at DESC")
  end

  def create
    user = User.find_by(:id => current_user.id)
    product = Product.find_by(:id => params[:product_id])

    if user.account.orders.find_by(:product_id => product.id)
      flash[:alert] = "You have already bought the rights to this image!"
      redirect_to products_path
      return
    end

    begin
      if user.account.balance >= product.price
        ActiveRecord::Base.transaction do
          user.account.update(:balance => user.account.balance - product.price)
          Order.create(:user_id => user.id, :account_id => user.account.id, :product_id => product.id, :cost => product.price)
          flash[:notice] = "Successfully placed your order!"
        end
      else
        flash[:alert] = "Unable to place your order, due to an insufficient account balance!"
        redirect_to user_account_path(current_user.id)
        return
      end
    rescue => exception
      flash[:alert] = "Failed to place the order!"
    end

    redirect_to user_orders_path(current_user.id)
  end
end
