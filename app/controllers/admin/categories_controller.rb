class Admin::CategoriesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    response = @category.save

    if response == true
      flash[:notice] = "Created new category!"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "Category name field cannot be blank!"
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    response = @category.update(category_params)

    if response == true
      flash[:notice] = "Category has been updated!"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "Failed to update category!"
      render :edit
    end
  end

  def destroy
    response = Category.destroy(params[:id])

    if response == true
      flash[:notice] = "Category has been deleted!"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "Failed to delete category!"
      render :destroy
    end
  end

  private 

  def category_params
    params.require(:category).permit(:name)
  end
end
