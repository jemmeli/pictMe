class SendSmsJob < ActiveJob::Base
  queue_as :normal

  def perform(payload)
    RestClient.post SMS_PATH, {
      login: SMS_LOGIN,
      apiKey: SMS_API_KEY,
      smsData: payload
    }
  end
end
