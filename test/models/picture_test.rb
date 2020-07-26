require "test_helper"

describe Picture do
  let(:picture) { Picture.new }

  it "must be valid" do
    value(picture).must_be :valid?
  end
end
