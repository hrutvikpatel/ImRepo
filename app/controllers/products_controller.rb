class ProductsController < ApplicationController
  def index
    @user = current_user
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
