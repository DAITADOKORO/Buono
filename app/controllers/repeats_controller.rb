class RepeatsController < ApplicationController
  def index
    @repeats = Repeat.group(:restaurant_id).order("count(restaurant_id) desc")
    @tags = Restaurant.tag_counts_on(:tags).order('count DESC')
  end

  def show
    @user = User.find(params[:user_id])
    @repeats = @user.repeats
  end

  def tag_cloud
    @tags = Restaurant.tag_counts_on(:tags).order('count DESC')
    @restaurants = Restaurant.tagged_with(params[:tag_name])
    @hoge = Repeat.where(restaurant_id: @restaurants.ids)
    @repeats = @hoge.group(:restaurant_id).order("count(restaurant_id) desc")
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
