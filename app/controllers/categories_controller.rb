class CategoriesController < ApplicationController
  def index
    @categories = Category.search(params[:search])
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.all
  end

  private

  def categories_params
    params.require(:category).permit(:search)
  end
end
