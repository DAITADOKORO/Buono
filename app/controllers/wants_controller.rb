class WantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wants = Want.group(:restaurant_id).order("count(restaurant_id) desc").page(params[:page]).per(10)
    @tags = Restaurant.tag_counts_on(:tags).order('count DESC')
  end

  def show
    @user = User.find(params[:user_id])
    @wants = @user.wants.page(params[:page]).per(10)
  end

  def tag_cloud
    @tags = Restaurant.tag_counts_on(:tags).order('count DESC')
    @restaurants = Restaurant.tagged_with(params[:tag_name])
    @hoge = Want.where(restaurant_id: @restaurants.ids)
    @wants = @hoge.group(:restaurant_id).order("count(restaurant_id) desc").page(params[:page]).per(10)
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
