class API::V1::ResultsController < API::V1::ApplicationController
  before_action :set_result, only: [:show, :update, :destroy]
  before_action :set_race, only: [:index, :create]
  before_action :set_edition, only: [:index, :create]
  before_action :set_runner, only: [:index, :create]

  def index
    if @race
      @results = Result.where(race: @race).order('created_at desc')
    elsif @runner
      @results = Result.where(runner: @runner).order('created_at desc')
    elsif @edition
      @results = Result.where(edition: @edition).order('created_at desc')
    end
    if @results
      render json: @results, root: 'results'
    else
      render json: {}, status: :bad_request
    end
  end

  def show
    if @result
      render json: @result
    else
      render json: {}, status: :not_found
    end
  end

  def create
    begin
      if params[:result].nil?
        render json: {}, status: :bad_request
      else
        if @race
          @result = @race.results.new(result_params)
        elsif @runner
          @result = @runner.results.new(result_params)
        elsif @edition
          @result = @edition.results.new(result_params)
        else
          render json: {}, status: :not_found
        end
        if @result && @result.save
          render json: @result, status: :created
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
      if @result.update(result_params)
        render json: @result
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
      if @result
        @result.destroy
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

  def set_result
    @result = Result.find_by(id: params[:id])
  end

  def result_params
    params.require(:result).permit(
        :id,
        :race_id,
        :phone,
        :mail,
        :name,
        :country,
        :bib,
        :categ_rank,
        :categ,
        :sex_rank,
        :sex,
        :time,
        :speed,
        :message,
        :race_detail,
        :email_sent_at,
        :sms_sent_at,
        :diploma_url,
        :edition_id,
        :runner_id,
        :points,
        :first_name,
        :last_name,
        :dob
    )
  end

end
