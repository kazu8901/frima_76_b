class ExhibitionsController < ApplicationController

  def new
    @exhibition = Exhibition.new
    @exhibition.images.build
  end

  def create
    @exhibition = Exhibition.new(exhibition_params)
    if @exhibition.save
      redirect_to root_path
    else
      redirect_to new_exhibition_path
    end
  end

  def show
    @exhibition = Exhibition.find(params[:id])
  end

  def edit

  end

  def update

  end

  private
  def exhibition_params
    params.require(:exhibition).permit(:name, :explanatory, :cost, :prefecture_code, :day, :price, :status, :category_id,:brand_id, images_attributes: [:image, :id],).merge(user_id: current_user.id)
  end

  def confirm
    @exhibition = Exhibition.find(params[:id])
  end

end