class ProductsController < ApplicationController
  def index
    @products = Product.search(params[:search])
  end

  def show
    @product = Product.find(params[:id])
  end

  private
  
  def products_params
    params.require(:product).permit(:search)
  end
end
