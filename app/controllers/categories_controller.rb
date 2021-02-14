class CategoriesController < ApplicationController
  def index
    @categories = Category.search(params[:search])
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.all
  rescue StandardError
    flash[:alert] = 'Category was not found!'
    redirect_to categories_path
  end
end
