class Admin::ImagesController < ApplicationController
  
  before_action :authenticate_admin!

  def index
    @images = Image.all
  end

  def new
    @images = Image.new
  end

  def create
    @image = Image.new(image_params)
    response = @image.save

    if response == true
      @categories = params.dig(:image, :category_ids)

      @categories.each do |category|
        @category = Category.find(category)
        @image.categories << @category
      end

      flash[:notice] = "Created new image!"
      redirect_to admin_images_path
    else
      flash.now[:alert] = "Image fields cannot be blank!"
      render 'admin/products/new'
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    response = @image.update(image_params)

    if response == true
      @image.image_categories.destroy_all
      @categories = params.dig(:product, :category_ids)

      @category.each do |category|
        @category = Category.find(catgory)
        @image.categories << @category
      end

      flash[:notice] = "Image has been updated!"
      redirect_to admin_images_path
    else
      flash.now[:alert] = "Failed to delete image!"
      render :edit
    end
  end

  def destroy
    response = Image.destroy(params[:id])

    if response == true
      flash[:notice] = "Image has been deleted!"
      redirect_to admin_images_path
    else
      flash.now[:alert] = "Failed to delete the image!"
      render :destroy
    end
  end
end
