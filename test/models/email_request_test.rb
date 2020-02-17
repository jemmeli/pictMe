require "test_helper"

describe EmailRequest do
  let(:email_request) { EmailRequest.new }

  it "must be valid" do
    value(email_request).must_be :valid?
  end
end
