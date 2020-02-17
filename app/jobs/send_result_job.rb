class SendResultJob < ActiveJob::Base
  queue_as :normal

  def perform(result)
    @result = Result.find(result)

    # Envoi du mail
    ResultMailer.mail_result(@result).deliver_later if @result.mail =~ MAIL_REGEX && @result.email_sent_at.nil?

    # Envoi du SMS
    unless @result.sms_sent_at
      @result.sms.send
      @result.update_attribute(:sms_sent_at, Time.now)
    end
  end
end