class PaymentsController < ApplicationController
  before_action :set_result

  def show
    if params[:sending_type] == 'email'
      redirect_to root_path, status: :forbidden unless @result.edition.download_chargeable?
    else
      redirect_to root_path, status: :forbidden unless @result.edition.sendable_at_home?
    end
  end

  def create
    service = DiplomaPurchaseService.new(@result, params)
    service.perform
    redirect_to result_path(@result.id), flash: service.flash
  end

  private

  def set_result
    @result = Result.find params[:result_id]
  end
end
