class API::V1::EditionsController < API::V1::ApplicationController
  before_action :set_edition, only: [:show, :update, :destroy]
  before_action :set_event, only: [:index, :show, :create]

  def index
    @editions = @event.editions.order('created_at desc')
    render json: @editions, root: 'editions'
  end

  def show
    if @edition
      render json: @edition
    else
      render json: {}, status: :not_found
    end
  end

  def create
    begin
      if params[:edition].nil?
        render json: {}, status: :bad_request
      else
        if @event
          @edition = @event.editions.new(edition_params)
          if @edition.save
            render json: @edition, status: :created
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
      if @edition.update(edition_params)
        render json: @edition
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
      if @edition
        @edition.destroy
        render json: {}, status: :no_content
      else
        render json: {}, status: :not_found
      end
    end
  end

  private

  def set_event
    @event = Event.find_by(id: params[:event_id])
  end

  def set_edition
    @edition = Edition.find_by(id: params[:id]) if params[:id]
  end

  def edition_params
    params.require(:edition).permit(
      :date,
      :description,
      :event_id,
      :email_sender,
      :email_name,
      :hashtag,
      :results_url,
      :sms_message,
      :template,
      :external_link,
      :external_link_button,
      :raw_results_file_name,
      :raw_results_content_type,
      :raw_results_file_size,
      :background_image_file_name,
      :background_image_content_type,
      :background_image_file_size,
      :sendable_at_home,
      :sendable_at_home_price_cents,
      :download_chargeable,
      :download_chargeable_price_cents
    )
  end
end
