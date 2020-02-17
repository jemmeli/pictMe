class API::V2::EventsController < API::V2::ApplicationController
  def index
    @events = Event.joins(:editions).order('editions.date ASC')

    query_params = params[:query_params]

    if query_params.present?
      begin_date = query_params[:begin_date]
      end_date   = query_params[:end_date]
      
      if begin_date && begin_date != ''
        @events = Event.joins(:editions).where("DATE(editions.date) >= ? AND DATE(editions.date) <= ?", begin_date, end_date).order('editions.date ASC')
      end
    end

    render json: @events.to_json
  end
end
