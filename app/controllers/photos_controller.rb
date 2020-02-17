class PhotosController < ApplicationController
  before_action :set_event, only: %I[index create destroy_all]
  before_action :set_edition, only: %I[index create destroy_all]
  before_action :set_photo, only: %I[update destroy]

  def index
    photo_ids = PhotoSearchService.new(@edition, params).fetch_ids
    @photos = @edition.photos.where(id: photo_ids).paginate(page: params[:page], per_page: 30).order(created_at: :desc)
  end

  def create
    @photo = @edition.photos.create! photo_params
  end

  def update
    @success = @photo.update(photo_params)
    respond_to do |format|
      format.js
      if @success
        format.html { redirect_to @photo, notice: 'photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @photo.destroy
      redirect_to event_edition_photos_path(event_id: @photo.edition.event_id, edition_id: @photo.edition_id), notice: 'Photo supprimée.'
    else
      redirect_to event_edition_photos_path(event_id: @photo.edition.event_id, edition_id: @photo.edition_id), alert: "La photo n'a pas pu être supprimée"
    end
  end

  def destroy_all
    @photos = @edition.photos.where(id: params[:photo_ids])
    @photos.destroy_all
    redirect_to event_edition_photos_path(event_id: @event.id, edition_id: @edition.id), notice: "Les photos ont bien été supprimées."
  end

  private

  def set_event
    @event = Event.find params[:event_id]
  end

  def set_edition
    @edition = Edition.find params[:edition_id]
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(
      :id,
      :bib,
      :direct_image_url
    )
  end
end
