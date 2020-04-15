require "test_helper"

describe SendEmailModalMailer do
  it "help_csv" do
    mail = SendEmailModal.help_csv
    value(mail.subject).must_equal "Help csv"
    value(mail.to).must_equal ["to@example.org"]
    value(mail.from).must_equal ["from@example.com"]
    value(mail.body.encoded).must_match "Hi"
  end
end
