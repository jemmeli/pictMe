class RunnersController < ApplicationController
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD']

  def index
    runners = params[:q].present? ? Runner.with_name(params[:q]) : Runner.all
    @runners = runners.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @runner = Runner.find(params[:id])
    @results = @runner.results
    @scores = @runner.scores
  end

  private
  def set_runner
    @runner = Runner.find(params[:id])
  end

  def runners_params
    params.require(:runners).permit(
        :id,
        :first_name,
        :last_name,
        :dob,
        :department,
        :sex
    )
  end
end
