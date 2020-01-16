class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @wants = @user.wants
    @repeats = @user.wants
  end


  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
       if @user.update(user_params)
      redirect_to user_path(current_user.id), notice: '更新しました。'
   else
      render :edit
   end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end

private
  def user_params
    params.require(:user).permit(:email, :name, :name_kana,:deleted_at)
  end

end
