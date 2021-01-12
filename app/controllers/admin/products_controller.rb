class Admin::ProductsController < ApplicationController
  
  before_action :authenticate_admin!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    response = @product.save

    if response == true
      @categories = params.dig(:product, :category_ids)

      @categories.each do |category|
        @category = Category.find(category)
        @product.categories << @category
      end

      flash[:notice] = "Created new product!"
      redirect_to admin_products_path
    else
      flash.now[:alert] = "Product fields cannot be blank!"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    old_category = @product.categories
    response = @product.update(product_params)
    new_category = @product.categories

    if response == true
      if old_category != new_category
        @product.product_categories.destroy_all
        @categories = params.dig(:product, :category_ids)

        @category.each do |category|
          @category = Category.find(catgory)
          @product.categories << @category
        end
      end

      flash[:notice] = "Product has been updated!"
      redirect_to admin_products_path
    else
      flash.now[:alert] = "Failed to delete product!"
      render :edit
    end
  end

  def destroy
    response = Product.destroy(params[:id])

    if response == true
      flash[:notice] = "Product has been deleted!"
    else
      flash.now[:alert] = "Failed to delete the product!"
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end
end
