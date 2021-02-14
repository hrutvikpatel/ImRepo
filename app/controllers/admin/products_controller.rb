class Admin::ProductsController < ApplicationController
  
  before_action :authenticate_admin!

  def index
    @products = Product.search(params[:search])
  end

  def new
    if Category.count == 0
      flash[:alert] = "You need to first create at least one category!"
      redirect_to admin_products_path
    else
      @product = Product.new
    end
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @product = Product.new(product_params)
        @categories = params.dig(:product, :category_ids)

        @categories&.each do |category|
          @category = Category.find(category)
          @product.categories << @category
        end

        @product.save!

        flash[:notice] = "Created new product!"
        redirect_to admin_products_path
      end
    rescue => exception
      puts exception
      flash.now[:alert] = "Failed to create new product!"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        @product = Product.find(params[:id])
        @product.assign_attributes(product_params)
        new_category_ids = params.dig(:product, :category_ids)&.map(&:to_i)
        old_category_ids = @product.categories.pluck(:id)
  
        if old_category_ids != new_category_ids
          @product.product_categories.destroy_all
          @categories = params.dig(:product, :category_ids)

          @categories&.each do |category|
            @category = Category.find(category)
            @product.categories << @category
          end
        end

        @product.update!(product_params)

        flash[:notice] = "Product has been updated!"
        redirect_to admin_products_path
      end
    rescue => exception
      flash.now[:alert] = "Failed to update product!"
      render :edit
    end
  end

  def destroy
    begin
      if Order.where(:product_id => params[:id]).count != 0
        flash[:alert] = "Cannot delete a product that has been ordered by a customer!"
        redirect_to admin_products_path
        return
      end
      response = Product.destroy(params[:id])
      flash[:notice] = "Product has been deleted!"
    rescue => exception
      flash[:alert] = "Failed to delete the product!"
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:image, :title, :description, :price, :search, :category_ids)
  end
end
