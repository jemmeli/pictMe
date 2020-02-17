class MailViewersController < ApplicationController
  def result
    @result = Result.find(params[:id])
    render 'result_mailer/mail_result.html.erb'
  end
end
