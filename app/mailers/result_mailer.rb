class ResultMailer < ApplicationMailer

  #Envoi un mail au participant
  def mail_result(result)
    @result = Result.find(result)
    return unless @result.diploma? && @result.mail

    subject = I18n.t('mail_subject', edition_name_mail: @result.edition.event.name)
    mail to: @result.mail, from: I18n.t('mail_sender', sender_mail: @result.race.email_sender), subject: subject
    @result.update_attribute(:email_sent_at, Time.now)
  end

  def mail_original_diploma(result_id, send_diploma_by_email, params = {})
    @result = Result.find(result_id)
    @send_diploma_by_email = send_diploma_by_email

    return unless @result.diploma? && @result.mail && @result.purchased_at?

    attachments['diploma.jpg'] = {
      mime_type: 'image/jpeg',
      encoding: 'base64',
      content: open(@result.diploma.url).read
    } if @send_diploma_by_email

    subject = I18n.t('mail_original_diploma_subject', edition_name_mail: @result.edition.event.name)

    mail to: params[:email] || @result.mail, from: I18n.t('mail_sender', sender_mail: @result.race.email_sender), subject: subject
  end

  
  def mail_diploma(result_id, email, name, params = {})
    @result = Result.find(result_id)
    @send_diploma_by_email = true
    @email = email
    @name = name
    @url = @result.diploma.url

    p @url
    p @name

    return unless @url # && @result.purchased_at?

    image_data  = open(@url) {|f| f.read }

    # p image_data

    attachments['diploma.jpg'] = {
      mime_type: 'image/jpeg',
      encoding: 'base64',
      content: Base64.encode64(image_data)
    } 

    subject = I18n.t('mail_original_diploma_subject', edition_name_mail: @result.edition.event.name)

    mail to: @email, from: I18n.t('mail_sender', sender_mail: @result.race.email_sender), subject: subject
  end
end
