class PhotosController < ApplicationController
  def index
    @photos = Photo.all
    render({ :template => "photos/all_photos.html.erb"})
  end

  def create
    user_id = session.fetch(:user_id)
    image = params.fetch("input_image")
    caption = params.fetch("input_caption")
    photo = Photo.new
    photo.owner_id = user_id
    photo.image = image
    photo.caption = caption
    photo.save
    redirect_to("/photos/#{photo.id}")
  end

  def show
    p_id = params.fetch("the_photo_id")
    @photo = Photo.where({:id => p_id }).first
    render({:template => "photos/details.html.erb"})
  end

  def destroy
    id = params.fetch("the_photo_id")
    photo = Photo.where({ :id => id }).at(0)
    photo.destroy

    redirect_to("/photos")
  end

  def update
    user_id = session.fetch(:user_id)
    id = params.fetch("the_photo_id")
    photo = Photo.where({ :id => id }).at(0)
    if photo.owner_id == user_id
      photo.caption = params.fetch("input_caption")
      photo.image = params.fetch("input_image")
      photo.save
      redirect_to("/photos/#{photo.id}", { :notice => "Photo updated!"})
    else
      redirect_to("/photos/#{photo.id}", { :notice => "Photo could not be updated."})
    end
  end
end
