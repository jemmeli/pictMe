class API::V1::EventsController < API::V1::ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.order('created_at desc')
    render json: @events, root: 'events'
  end

  def show
    if @event
      render json: @event
    else
      render json: {}, status: :not_found
    end
  end

  def create
    begin
      if params[:event].nil?
        render json: {}, status: :bad_request
      else
        @event = Event.new(event_params)
        if @event.save
          render json: @event, status: :created
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
      if params[:id].nil? || params[:event].nil?
        render json: {}, status: :bad_request
      else
        if @event
          if @event.update(event_params)
            render json: @event
          else
            render json: {}, status: :not_modified
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

  def destroy
    if params[:id].nil?
      render json: {}, status: :bad_request
    else
      if @event
        @event.destroy
        render json: {}, status: :no_content
      else
        render json: {}, status: :not_found
      end
    end
  end

  private
  def set_event
    @event = Event.find_by(id: params[:id])
  end

  def event_params
    params.require(:event).permit(
        :id,
        :name,
        :place,
        :website,
        :facebook,
        :twitter,
        :instagram,
        :contact,
        :email,
        :phone
    )
  end
end
