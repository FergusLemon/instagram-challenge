class PhotosController < ApplicationController

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

  def photo_params
    params.require(:photo).permit(:description, :image)
  end
   
end
