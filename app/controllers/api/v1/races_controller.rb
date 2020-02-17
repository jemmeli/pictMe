class API::V1::RacesController < API::V1::ApplicationController
  before_action :set_race, only: [:show, :update, :destroy]
  before_action :set_edition, only: [:index, :show, :create]

  def index
    @races = Race.where(edition: @edition).order('date desc')
    render json: @races, root: 'races'
  end

  def show
    if @race
      render json: @race
    else
      render json: {}, status: :not_found
    end
  end

  def create
    begin
      if params[:race].nil?
        render json: {}, status: :bad_request
      else
        if @edition
          @race = @edition.races.new(race_params)
          if @race.save
            render json: @race, status: :created
          else
            render json: {}, status: :unprocessable_entity
          end
        else
          render json: {}, status: :not_found
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
      if @race.update(race_params)
        render json: @race
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
      if @race
        @race.destroy
        render json: {}, status: :no_content
      else
        render json: {}, status: :not_found
      end
    end
  end

  private
  def set_edition
    if params[:edition_id]
      @edition = Edition.find_by(id: params[:edition_id])
    end
  end

  def set_race
    @race = Race.find_by(id: params[:id])
  end

  def race_params
    params.require(:race).permit(
        :name,
        :email_sender,
        :email_name,
        :date,
        :hashtag,
        :results_url,
        :sms_message,
        :created_at,
        :updated_at,
        :raw_results_file_name,
        :raw_results_content_type,
        :raw_results_file_size,
        :background_image_file_name,
        :background_image_content_type,
        :background_image_file_size,
        :template,
        :external_link,
        :external_link_button,
        :edition_id,
        :coef,
        :category,
        :department,
        :race_type
    )
  end

end
