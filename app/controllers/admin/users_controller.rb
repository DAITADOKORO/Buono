class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"


  def index
    @users = User.all.with_deleted
  end

  def show
    @user = User.with_deleted.find(params[:id])
  end


  def edit
    @user = User.with_deleted.find(params[:id])
  end

  def update
    @user = User.with_deleted.find(params[:id])
       if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: '更新しました。'
   else
      render :edit
   end
  end
  def user_restore
    @user = User.only_deleted.find(params[:id]).restore
    redirect_to admin_users_path
  end

  def destroy
    @user = User.with_deleted.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
private
  def user_params
    params.require(:user).permit(:email, :name, :name_kana,:deleted_at)
  end

end
