class API::V1::SearchesController < API::V1::ApplicationController
  def show
    query_params = params["query_params"]
    if query_params
      event_name       = query_params
      @events          = Event.where("name ILIKE ?", "%#{event_name}%" ).limit(8)
      @detailed_events = set_detailed_events(@events)
    else
      @events          = Event.order(id: :asc).limit(8)
      @detailed_events = set_detailed_events(@events)
    end

    render json: @detailed_events
  end

  private

  def set_detailed_events(events)
    detailed_events = events.map do |event|
      {
        id: event.id,
        name: event.name,
        place: event.place,
        website: event.website,
        contact: event.contact,
        email: event.email,
        phone: event.phone,
        department: event.department,
        editions_count: event.editions.count,
        editions: set_detailed_editions(event)
      }
    end
  end

  def set_detailed_editions(event)
    event.editions.map do |edition|
      {
        date: edition.date,
        description: edition.description,
        races_count: edition.races.count,
        runners_count: edition.results.count,
        races: set_detailed_race(edition)
      }
    end
  end

  def set_detailed_race(edition)
    edition.races.map do |race|
      {
        name: race.name,
        date: race.date,
        coef: race.coef,
        category: race.category,
        department: race.department,
        race_type: race.race_type,
        runners_count: race.results.count
      }
    end
  end
end
