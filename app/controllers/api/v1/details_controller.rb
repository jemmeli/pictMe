class API::V1::DetailsController < API::V1::ApplicationController
  def index
    @events = Event.order(id: :desc).limit(10).map do |event|
      editions = event.editions.map do |edition|
        races = edition.races.map{ |race| race.attributes}

        edition.attributes.merge(races: races)
      end

      event.attributes.merge(editions: editions)
    end

    render json: @events
  end
end
