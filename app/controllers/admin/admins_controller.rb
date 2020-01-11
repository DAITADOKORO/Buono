class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"


  def index
    @admins = Admin.all.with_deleted
  end

  def show
    @admin = Admin.with_deleted.find(params[:id])
  end


  def edit
    @admin = Admin.with_deleted.find(params[:id])
  end

  def update
    @admin = Admin.with_deleted.find(params[:id])
       if @admin.update(admin_params)
      redirect_to admin_admin_path(@admin.id), notice: '更新しました。'
   else
      render :edit
   end
  end
  def user_restore
    @admin = Admin.only_deleted.find(params[:id]).restore
    redirect_to admin_admins_path
  end

  def destroy
    @admin = Admin.with_deleted.find(params[:id])
    @admin.destroy
    redirect_to admin_admins_path
  end
private
  def admin_params
    params.require(:admin).permit(:email, :name, :name_kana,:deleted_at)
  end

end
