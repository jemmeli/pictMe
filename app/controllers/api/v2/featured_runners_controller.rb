class API::V2::FeaturedRunnersController < API::V2::ApplicationController
  def index
    @runners= Runner.order("RANDOM()").limit(4)
    render json: @runners.to_json
  end
end
