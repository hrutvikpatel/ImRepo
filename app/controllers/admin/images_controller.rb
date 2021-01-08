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
      render :new
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    old_category = @image.categories
    response = @image.update(image_params)
    new_category = @image.categories

    if response == true
      if old_category != new_category
        @image.image_categories.destroy_all
        @categories = params.dig(:image, :category_ids)

        @category.each do |category|
          @category = Category.find(catgory)
          @image.categories << @category
        end
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
    else
      flash.now[:alert] = "Failed to delete the image!"
    end
    redirect_to admin_images_path
  end

  private

  def image_params
    params.require(:image).permit(:title, :description, :price)
  end
end
