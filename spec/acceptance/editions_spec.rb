require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Editions" do
  let(:access_token) { 'test' }

  # Headers which should be included in the request
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', "Bearer #{:access_token}"

  # A specific endpoint
  get "api/v2/editions" do
    parameter :with_lastest_results, "If set to `true`, return only editions with results."
    parameter :last, "Resturn the last `n` editions."

    let(:with_lastest_results) { true }
    let(:last) { 3 }

    example "Listing editions" do
      explanation "Listing editions with limitation and filter  with result."

      2.times { create(:edition) }

      do_request

      expect(status).to eq(200)
    end
  end
end
