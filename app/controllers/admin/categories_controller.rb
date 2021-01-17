class Admin::CategoriesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @categories = Category.search(params[:search])
  end

  def new
    @category = Category.new
  end

  def create
    begin
      @category = Category.new(category_params)
      @category.save!
      flash[:notice] = "Created new category!"
      redirect_to admin_categories_path
    rescue => exception
      flash.now[:alert] = "Failed to create category!"
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    begin
      @category = Category.find(params[:id])
      @category.update!(category_params)
      flash[:notice] = "Category has been updated!"
      redirect_to admin_categories_path
    rescue => exception
      flash.now[:alert] = "Failed to update category!"
      render :edit
    end
  end

  def destroy
    begin
      if Category.find(params[:id]).products.first != nil
        flash[:alert] = "Category cannot be delete if it contains more than one product!"
      else
        Category.destroy(params[:id])
        flash[:notice] = "Category has been deleted!"
      end
    rescue => exception
      flash[:alert] = "Failed to delete category!"
    end

    redirect_to admin_categories_path
  end

  private 

  def category_params
    params.require(:category).permit(:name, :search)
  end
end
