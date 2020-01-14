class RestCommentsController < ApplicationController
  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    comment = current_user.rest_comments.new(rest_comment_params)
    comment.restaurant_id = restaurant.id
    comment.save
    redirect_to restaurant_rest_comments_path(restaurant)
  end
  def show
    @restaurant = Restaurant.find(params[:restaurant_id])

  end

  private
  def rest_comment_params
      params.require(:rest_comment).permit(:user_id,:restaurant_id,:comment)
  end

end
