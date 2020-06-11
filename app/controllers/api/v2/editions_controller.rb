class API::V2::EditionsController < API::V2::ApplicationController
  def index
    query_params = params["query_params"] || {}
    limit        = query_params['limit'] || 16

    number_of_elements_by_page = query_params["number_of_elements_by_page"] || 16
    page_number                = query_params["page_number"] || 1
    offset                     = (page_number - 1) * number_of_elements_by_page

    if query_params.present?

      @begin_date = query_params[:search_inputs][:begin_date]
      @end_date   = query_params[:search_inputs][:end_date]
      @event_name = query_params[:search_inputs][:event_name] || ""
      @event_name = NormalizeStringService.new(@event_name).call
      @place      = query_params[:search_inputs][:place]      || ""
      @types      = query_params[:search_inputs][:types]      || []
      order_direction = query_params[:search_inputs][:order] == 'asc' ? :asc : :desc

      construct_sql_query

      editions = Edition.available.
                         select(selected_attributes).
                         joins(:event).
                         left_outer_joins(races: :results).
                         where(@sql_query.join(' AND '), *@sql_params).
                         group('editions.id, events.id').
                         offset(offset).
                         limit(number_of_elements_by_page).
                         order(date: order_direction).
                         as_json(include: [:races, :event])

      number_of_editions = Edition.available.
                                   select(selected_attributes).
                                   joins(:event).
                                   left_outer_joins(races: :results).
                                   where(@sql_query.join(' AND '), *@sql_params).
                                   group('editions.id, events.id').
                                   count('editions.id').
                                   count
    else
      editions = Edition.available.
                         select(selected_attributes).
                         joins(:event).
                         left_outer_joins(races: :results).
                         group('editions.id, events.id').
                         offset(offset).
                         limit(number_of_elements_by_page).
                         order(date: :desc).
                         as_json(include: [:races, :event])

      number_of_editions = Edition.available.
                                   joins(:event).
                                   left_outer_joins(races: :results).
                                   count
    end

    theorical_number_of_pages = (number_of_editions.to_f / number_of_elements_by_page).ceil
    number_of_pages           = theorical_number_of_pages.zero? ? 1 : theorical_number_of_pages

    response = {
      number_of_pages: number_of_pages,
      editions:        editions,
    }

    render json: response
  end

  def show
    id = params[:id]
    edition    = Edition.available.find_by(id: id)
    return unless edition

    event      = edition.event

    query_params = params["query_params"]||{}
    if query_params["race_id"]
      race_id = query_params["race_id"]
    else
      race_id = edition.races.order(name: :asc).first.id
    end
    
    @race                 = Race.available.find_by(id: race_id)
    return unless @race

    @bibs = Result.includes(:race).where("races.id = ?", @race.id).pluck(:bib)
    @photos_with_results = Photo.where(bib: @bibs, edition_id: @race.edition_id)

    edition_photos_count = @photos_with_results.count

    edition_modes = ['description', 'results', 'photos']
    if query_params["edition_mode"] && edition_modes.include?(query_params["edition_mode"])
      edition_mode  = query_params["edition_mode"]
    else
      edition_mode  = edition_modes.first
    end

    if edition_mode == 'results'
      categories   = @race.results.select(:categ).distinct.order(:categ).pluck(:categ).map(&:upcase)
      sexes        = @race.results.joins(:runner).where.not("runners.sex IS ?", nil).distinct.pluck('runners.sex').map(&:upcase)

      selection = <<~SQL
        runners.id AS runner_id,
        results.rank AS rank,
        runners.first_name AS first_name,
        runners.last_name AS last_name,
        UPPER(runners.sex) AS sex,
        UPPER(results.categ) AS categ,
        results.speed AS speed,
        results.time AS time,
        races.id
      SQL

      race_results = Result.joins(:race, :runner).select(selection).where("races.id= ?", @race.id).order(:rank)

      results = {
        categories: categories,
        sexes:      sexes,
        data:       race_results,
      }
    elsif edition_mode == 'photos'
      photos = edition_photos
    end

    races = edition.races.order(name: :asc).map do |race|
      if race.id == race_id
        race_results = results
        race_photos  = photos
      end
      {
        id:                  race.id,
        name:                race.name,
        race_type:           race.race_type,
        participants_number: race_participants_number(race),
        results:             race_results,
        photos:              race_photos,
      }
    end

    response = {
      event_name:           event.name,
      name:                 edition.description,
      registration_link:    edition.registration_link,
      place:                event.place,
      latitude:             event.latitude,
      longitude:            event.longitude,
      date:                 edition.date,
      website:              event.website,
      phone:                event.phone,
      races:                races,
      edition_photos_count: edition_photos_count,
    }

    render json: response
  end

  def calendar
    query_params    = params['query_params'] || {}
    current_date    = Date.parse(query_params['start_date']) || Time.now

    month_beginning = Date.new(current_date.year, current_date.month, 1)
    start_date      = month_beginning - 7.days
    end_date        = Date.new(current_date.year, current_date.month, 1) + 1.month + 7.days

    month_editions  = Edition.available.
                              where('date >= ? AND date <= ?', start_date, end_date)
    response        = month_editions.map do |edition|
      event = edition.event
      {
        id:               edition.id,
        event_name:       event&.name,
        event_department: event&.department,
        name:             edition.description,
        date:             edition.date,
      }
    end

    render json: response
  end

  def search_list
    query_params = params['query_params']||{}
    search_query = query_params['search_query']||""
    search_query = NormalizeStringService.new(search_query).call

    response     = Edition.available.
                           joins(:event).
                           where('unaccent(events.name) ILIKE ?', "%#{search_query}%").
                           order("events.name ASC").
                           limit(10)
    response     = response.map do |edition|
      {
        id:           edition.id,
        event_name:   edition.event.name,
        edition_date: edition.date,
      }
    end

    render json: response
  end

  private

  def selected_attributes
    [
      'editions.id',
      'editions.date',
      'events.name  AS name',
      'events.name  AS event_name',
      'events.id    AS event_id',
      'events.place AS place',
      'events.latitude',
      'events.longitude',
      'editions.description',
      'editions.event_id',
      'editions.email_sender',
      'editions.email_name',
      'editions.hashtag',
      'editions.results_url',
      'editions.external_link',
      'editions.created_at',
      'editions.updated_at',
      'editions.background_image_file_name',
      'COUNT(results.id) AS number_of_participants',
    ]
  end

  def edition_hash(edition)
    event = edition.event

    {
      id:                              edition.id,
      date:                            edition.date,
      name:                            event.name,
      event_name:                      event.name,
      place:                           event.place,
      latitude:                        event.latitude,
      longitude:                       event.longitude,
      description:                     edition.description,
      event_id:                        edition.event_id,
      email_sender:                    edition.email_sender,
      email_name:                      edition.email_name,
      hashtag:                         edition.hashtag,
      results_url:                     edition.results_url,
      external_link:                   edition.external_link,
      created_at:                      edition.created_at,
      updated_at:                      edition.updated_at,
      background_image_file_name:      edition.background_image_file_name,
      races:                           edition.races,
      number_of_participants:          edition.runners_count
    }
  end

  def edition_photos
    @photos_with_results.map do |photo|
      {
        url:       ENV['RAILS_ENV'] == 'development' ? photo.direct_image_url : photo.image.url,
        race_name: @race&.name,
      }
    end
  end

  def construct_sql_query
    @sql_query  = []
    @sql_params = []

    if @begin_date.present?
      @sql_query << <<~SQL
        DATE(editions.date) >= ? AND DATE(editions.date) <= ?
      SQL

      @sql_params += [@begin_date, @end_date]
    end

    if @event_name.present?
      @sql_query << <<~SQL
        unaccent(events.name) ILIKE ?
      SQL

      @sql_params += ["%#{@event_name}%"]
    end

    if @place.present?
      @sql_query << <<~SQL
        LOWER(events.place) LIKE ?
      SQL

      @sql_params += ["%#{@place.downcase}%"]
    end

    if @types.any?
      types_query = []

      @types.each do |type|
        types_query << <<~SQL
          races.race_type = ?
        SQL
      end

      @sql_query << "(#{types_query.join(' OR ')})"
      @sql_params += @types
    end
  end

  def build_previous_edition(race)
    return unless race&.edition&.event

    race.edition.
         event.
         editions.
         where.not('editions.id = ?', race.edition.id).
         order(date: :desc).
         first
  end

  def build_previous_race(previous_edition, race)
    return unless previous_edition&.races && !previous_edition&.races.empty?

    previous_edition.races.
                     where('races.name = ?', race.name.strip).
                     first
  end

  def race_participants_number(race)
    previous_edition = build_previous_edition(race)
    previous_race    = build_previous_race(previous_edition, race)
    return 0 unless previous_race&.results

    previous_race.results.count
  end
end
