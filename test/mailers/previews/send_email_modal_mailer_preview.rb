# Preview all emails at http://localhost:3000/rails/mailers/send_email_modal_mailer
class SendEmailModalMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/send_email_modal_mailer/help_csv
  def help_csv
    SendEmailModalMailer.help_csv
  end

end
