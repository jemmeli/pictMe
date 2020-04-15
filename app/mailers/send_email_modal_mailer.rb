class SendEmailModalMailer < ApplicationMailer
  default from: "imenfakhri@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.send_email_modal_mailer.help_csv.subject
  #
  def help_csv(params)
    @body = params[:body]
    path = params[:contacts].tempfile.path
    filename = params[:contacts].original_filename
    attachments[filename] = File.read(path)

    mail to: "jemmeli84@gmail.com"
  end
end
