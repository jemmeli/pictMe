class API::V1::RunnersController < API::V1::ApplicationController
  before_action :set_runner, only: [:show, :edit, :update, :destroy]

  def index
    @runners = Runner.order('created_at desc')
    render json: @runners, root: 'runners'
  end

  def show
    if @runner
      render json: @runner
    else
      render json: {}, status: :not_found
    end
  end

  def create
    begin
      if params[:runner].nil?
        render json: {}, status: :bad_request
      else
        @runner = Runner.new(runner_params)
        if @runner.save
          render json: @runner, status: :created
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
      if params[:id].nil? || params[:runner].nil?
        render json: {}, status: :bad_request
      else
        if @runner
          if @runner.update(runner_params)
            render json: @runner
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
      if @runner
        @runner.destroy
        render json: {}, status: :no_content
      else
        render json: {}, status: :not_found
      end
    end
  end

  private
  def set_runner
    @runner = Runner.find_by(id: params[:id])
  end

  def runner_params
    params.require(:runner).permit(
        :id,
        :id_key,
        :first_name,
        :last_name,
        :dob,
        :department,
        :sex
        )
  end
end
