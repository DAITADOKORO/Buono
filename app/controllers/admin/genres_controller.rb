class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def index
    @genres = Genre.all.with_deleted
    @new_genre = Genre.new
  end

  def create
    @new_genre = Genre.new(genre_params)
    if @new_genre.save
      flash[:success] = "新しいジャンルを追加しました"
      redirect_to admin_genres_path
    else
      @genres = Genre.all.with_deleted
      render :index
    end
  end

  def update
   @genre = Genre.with_deleted.find(params[:id])
    if @genre.update(genre_params)
     @genres = Genre.all.with_deleted
     redirect_to admin_genres_path
    else
     render :edit and return
    end
  end

  def destroy
    @genre = Genre.with_deleted.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path
  end

private
  def genre_params
  params.require(:genre).permit(:genre_name, :deleted_at)
end

end