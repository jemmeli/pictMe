class API::V2::EditionsController < API::V2::ApplicationController
  def index
    query_params = params["query_params"] || {}
    limit        = query_params['limit'] || 16

    if query_params['with_lastest_results_races_data']
      editions_and_results = Edition.with_lastest_results(limit)

      editions = editions_and_results[:editions]
      results  = editions_and_results[:results]

      races = results.map do |result|
        Race.find(result.race_id)
      end

      events = editions.map do |edition|
        Event.find(edition.event_id)
      end

      render json: { editions: editions, races: races, events: events }

    elsif query_params['with_next_races_data']
      editions = Edition.next(limit)

      races = editions.map do |edition|
        edition.races.first
      end

      events = editions.map do |edition|
        Event.find(edition.event_id)
      end

      render json: { editions: editions, races: races, events: events }

    else
      editions = Edition.all

      number_of_elements_by_page = query_params["number_of_elements_by_page"] || 16
      page_number                = query_params["page_number"] || 1
      offset                     = (page_number - 1) * number_of_elements_by_page

      if query_params.present?

        begin_date = query_params[:search_inputs][:begin_date]
        end_date   = query_params[:search_inputs][:end_date]
        event_name = query_params[:search_inputs][:event_name] || ""
        place      = query_params[:search_inputs][:place] || ""
        types      = query_params[:search_inputs][:types] || []


        if begin_date && begin_date != ''
          editions = editions.where("DATE(editions.date) >= ? AND DATE(editions.date) <= ?", begin_date, end_date)
        end

        if event_name.present?
          editions = editions.joins(:event).where("LOWER(events.name) LIKE ?", "%#{event_name.downcase}%")
        end

        if place.present?
          editions = editions.joins(:event).where("LOWER(events.place) LIKE ?", "%#{place.downcase}%")
        end

        if types.any?
          editions = editions.joins(:races).where(races: {race_type: types })
        end
      end

      editions                  = editions.order(date: :desc)
      theorical_number_of_pages = (editions.count.to_f / number_of_elements_by_page).ceil
      number_of_pages           = theorical_number_of_pages.zero? ? 1 : theorical_number_of_pages
      editions_for_page         = editions.offset(offset).limit(number_of_elements_by_page)
      editions_data_for_page    = editions_for_page.map do |edition|
        edition_hash(edition)
      end

      response = {
        number_of_pages: number_of_pages,
        editions:        editions_data_for_page,
      }

      render json: response
    end
  end

  def show
    edition_id = params[:id]
    edition    = Edition.find(edition_id)
    event      = edition.event

    query_params = params["query_params"]||{}
    if query_params["race_id"]
      race_id = query_params["race_id"]
    else
      race_id = edition.races.order(name: :asc).first.id
    end
    race = Race.find(race_id)

    edition_modes = ['description', 'results', 'photos']
    if query_params["edition_mode"] && edition_modes.include?(query_params["edition_mode"])
      edition_mode  = query_params["edition_mode"]
    else
      edition_mode  = edition_modes.first
    end

    if edition_mode == 'results'
      race_results = race.results.order(rank: :asc)||[]
      categories   = race_results.pluck(:categ).uniq.map{|categ| categ.upcase}.sort
      sexes        = race_results.map{|res| res.runner.sex.upcase}.uniq.sort
      race_results = race_results.map do |res|
        {
          runner_id:  res.runner.id,
          rank:       res.rank,
          first_name: res.runner.first_name,
          last_name:  res.runner.last_name,
          sex:        res.runner.sex.upcase,
          categ:      res.categ.upcase,
          speed:      res.speed,
          time:       res.time,
        }
      end

      results = {
        categories: categories,
        sexes:      sexes,
        data:       race_results,
      }
    elsif edition_mode == 'photos'
      results_with_photos = race.results.select{|result| result.photo.class == Photo}
      photos              = results_with_photos.map do |result|
        photo = result.photo
        {
          url:       ENV['RAILS_ENV'] == 'development' ? photo.direct_image_url : photo.image.url,
          race_name: result.race.name,
        }
      end
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
        participants_number: race.results.count,
        results:             race_results,
        photos:              race_photos,
      }
    end

    response = {
      event_name: event.name,
      name:       edition.description,
      place:      event.place,
      latitude:   event.latitude,
      longitude:  event.longitude,
      date:       edition.date,
      website:    event.website,
      phone:      event.phone,
      races:      races,
    }

    render json: response
  end

  def calendar
    query_params    = params['query_params'] || {}
    current_date    = Date.parse(query_params['start_date']) || Time.now

    month_beginning = Date.new(current_date.year, current_date.month, 1)
    start_date      = month_beginning - 7.days
    end_date        = Date.new(current_date.year, current_date.month, 1) + 1.month + 7.days

    month_editions  = Edition.where('date >= ? AND date <= ?', start_date, end_date)
    response        = month_editions.map do |edition|
      {
        id:   edition.id,
        name: edition.description,
        date: edition.date,
      }
    end

    render json: response
  end

  def search_list
    query_params = params['query_params']||{}
    search_query = query_params['search_query']||""

    response     = Edition.joins(:event).where('events.name ILIKE ?', "#{search_query}%").order("events.name ASC").limit(10)
    response     = response.map do |edition|
      {
        id:   edition.id,
        event_name: edition.event.name
      }
    end

    render json: response
  end

  private

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
      number_of_participants:          edition.runners_count#,
      # sms_message:                     edition.sms_message,
      # template:                        edition.template,
      # widget_generated_at:             edition.widget_generated_at,
      # photos_widget_generated_at:      edition.photos_widget_generated_at,
      # external_link_button:            edition.external_link_button,
      # raw_results_file_name:           edition.raw_results_file_name,
      # raw_results_content_type:        edition.raw_results_content_type,
      # raw_results_file_size:           edition.raw_results_file_size,
      # raw_results_updated_at:          edition.raw_results_updated_at,
      # background_image_content_type:   edition.background_image_content_type,
      # background_image_file_size:      edition.background_image_file_size,
      # background_image_updated_at:     edition.background_image_updated_at,
      # sendable_at_home:                edition.sendable_at_home,
      # sendable_at_home_price_cents:    edition.sendable_at_home_price_cents,
      # download_chargeable:             edition.download_chargeable,
      # download_chargeable_price_cents: edition.download_chargeable_price_cents,
    }
  end
end
