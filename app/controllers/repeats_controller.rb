class RepeatsController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:user_id])
    @repeats = @user.repeats
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    repeat = current_user.repeats.new(restaurant_id: @restaurant.id)
    repeat.save
  end
  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    repeat = current_user.repeats.find_by(restaurant_id: @restaurant.id)
    repeat.destroy
  end
end
