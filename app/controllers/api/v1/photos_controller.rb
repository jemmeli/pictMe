class API::V1::PhotosController < API::V1::ApplicationController

  before_action :set_photo, only: [:show, :update, :destroy]
  before_action :set_race, only: [:index, :create]
  before_action :set_edition, only: [:index, :create]
  before_action :set_runner, only: [:index, :create]
  skip_before_action :doorkeeper_authorize!

  
  #/api/v1/runner/:bib(.:format)  
  def getRunnerByBib
    @photo = Photo.where(bib: params[:bib]) 
    @runner = @photo.first.runner
    if @runner
      render json: @runner
    else
      render json: {}, status: :not_found
    end
  end

  def index
    if @race
      @photos = Photo.where(race: @race).order('created_at desc')
    elsif @runner
      @photos = Photo.where(runner: @runner).order('created_at desc')
    elsif @edition
      @photos = Photo.where(edition: @edition).order('created_at desc')
    end
    if @photos
      render json: @photos, root: 'photos'
    else
      render json: {}, status: :bad_request
    end
  end

  def show
    if @photo
      render json: @photo
    else
      render json: {}, status: :not_found
    end
  end

  def create
    begin
      if params[:photo].nil?
        render json: {}, status: :bad_request
      else
        if @race
          @photo = @race.photos.new(photo_params)
        elsif @runner
          @photo = @runner.photos.new(photo_params)
        elsif @edition
          @photo = @edition.photos.new(photo_params)
        else
          render json: {}, status: :not_found
        end
        if @photo && @photo.save
          render json: @photo, status: :created
        else
          render json: {}, status: :unprocessable_entity
        end
      end
    rescue ActionController::ParameterMissing
      render json: {}, status: :bad_request
    rescue
      render json: {}, status: :internal_server_error
    end
  end

  def update
    begin
      if @photo.update(photo_params)
        render json: @photo
      else
        render json: {}, status: :not_modified
      end
    rescue ActionController::ParameterMissing
      render json: {}, status: :bad_request
    rescue
      render json: {}, status: :internal_server_error
    end
  end

  def destroy
    if params[:id].nil?
      render json: {}, status: :bad_request
    else
      if @photo
        @photo.destroy
        render json: {}, status: :no_content
      else
        render json: {}, status: :not_found
      end
    end
  end


  private
  def set_race
    if params[:race_id]
      @race = Race.find_by(id: params[:race_id])
    end
  end

  def set_edition
    if params[:edition_id]
      @edition = Edition.find_by(id: params[:edition_id])
    end
  end

  def set_runner
    if params[:runner_id]
      @runner = Runner.find_by(id: params[:runner_id])
    end
  end

  def set_photo
    @photo = Photo.find_by(id: params[:id])
  end

  def photo_params
    params.require(:photo).permit(
        :race_id,
        :suggested_bibs,
        :bib,
        :image_file_name,
        :image_content_type,
        :image_file_size,
        :image_updated_at,
        :edition_id
    )
  end
end
