class PhotosController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
      if @photo.save
        redirect_to photos_path
      else
        render 'new'
      end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update(photo_params)
    redirect_to photos_path
  end

  def destroy
    @photo = Photo.find(params[:id])
    if current_user == @photo.user
      @photo.destroy
      flash[:notice] = 'Photo deleted successfully'
      redirect_to photos_path
    else
      flash[:alert] = 'You cannot delete another user\'s photos'
      redirect_to photos_path
    end
  end

  def photo_params
    params.require(:photo).permit(:description, :image)
  end

end
