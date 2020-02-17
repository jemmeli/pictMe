require "test_helper"

describe Diploma do
  let(:diploma) { Diploma.new }

  it "must be valid" do
    value(diploma).must_be :valid?
  end
end
