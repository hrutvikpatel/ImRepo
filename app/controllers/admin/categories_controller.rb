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

    if response
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

    if response
      flash[:notice] = "Category has been updated!"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "Failed to update category!"
      render :edit
    end
  end

  def destroy
    if Category.find(params[:id]).products.first != nil
      flash[:notice] = "Category cannot be delete if it contains more than one product!"
      return
    end

    response = Category.destroy(params[:id])

    if response
      flash[:notice] = "Category has been deleted!"
    else
      flash[:alert] = "Failed to delete category!"
    end
    redirect_to admin_categories_path
  end

  private 

  def category_params
    params.require(:category).permit(:name)
  end
end
