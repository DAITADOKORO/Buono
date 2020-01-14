class WantsController < ApplicationController
  def index
  end

  def show
  end

  def create
      @restaurant = Restaurant.find(params[:restaurant_id])
      want = current_user.wants.new(restaurant_id: @restaurant.id)
      want.save
  end
  def destroy
      @restaurant = Restaurant.find(params[:restaurant_id])
      want = current_user.wants.find_by(restaurant_id: @restaurant.id)
      want.destroy
  end

end
