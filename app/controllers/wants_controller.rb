class WantsController < ApplicationController
  def index
    @wants = Want.group(:restaurant_id).order("count(restaurant_id) desc")
    @tags = Restaurant.tag_counts_on(:tags).order('count DESC')
  end

  def show
    @user = User.find(params[:user_id])
    @wants = @user.wants
  end

  def tag_cloud
    @tags = Restaurant.tag_counts_on(:tags).order('count DESC')
    @restaurants = Restaurant.tagged_with(params[:tag_name])
    @hoge = Want.where(restaurant_id: @restaurants.ids)
    @wants = @hoge.group(:restaurant_id).order("count(restaurant_id) desc")  end

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
