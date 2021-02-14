class CategoriesController < ApplicationController
  def index
    @categories = Category.search(params[:search])
  end

  def show
    begin
      @category = Category.includes(:products).find(params[:id])
      @products = @category.products
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Category was not found!'
      redirect_to categories_path
    end
  end
end
