class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('mail_sender')
end
