class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.find_by(:user_id => params[:user_id]).order("created_at DESC")
  end
end
