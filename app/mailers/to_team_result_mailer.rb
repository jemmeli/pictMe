class ToTeamResultMailer < ApplicationMailer
  def mail_original_diploma(result_id, params)
    @result = Result.find(result_id)
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @address = params[:address]
    @postal_code = params[:postal_code]
    @city = params[:city]
    @country = params[:country]

    return unless @result.diploma? && @result.mail && @result.purchased_at?

    subject = I18n.t('mail_to_team_original_diploma_subject', edition_name_mail: @result.edition.event.name)

    mail to: ADMIN_EMAIL, from: ADMIN_EMAIL, subject: subject
  end
end
