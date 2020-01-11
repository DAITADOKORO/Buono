class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def index
    @restaurants = Restaurant.page(params[:page]).reverse_order

  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @genre = Genre.find(@admins_product.genre_id)
  end

  def new
    @restaurant = Restaurant.new

  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
   if @restaurant.save
    redirect_to admin_restaurant_path(@restaurant.id), notice: 'You have created product successfully.'
   else
    render :new
   end
  end
  def update
    @restaurant = Restaurant.find(params[:id])
       if @restaurant.update(restaurant_params)
      redirect_to admin_restaurant_path(@restaurant.id), notice: 'You have updated user successfully.'
   else
      render :edit
   end
  end

 private

  def restaurant_params
    params.require(:restaurant).permit(:genre_id, :image, :comment, :item_text, :item_name)
  end

end
