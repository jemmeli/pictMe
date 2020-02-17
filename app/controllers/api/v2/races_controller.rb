class API::V2::RacesController < API::V2::ApplicationController
  def index
    if params[:edition_id]
      render_edition_races
    else
      query = RaceQuery.relation(Race.available)

      if params[:next_races].present?
        limit = params[:next_races].to_i > 0 ? params[:next_races] : 15
        races = query.next_races.limit(limit.to_i)
      else
        limit = params[:lastest].presence || 15
        races = query.lastest_with_results.limit(limit.to_i)
      end

      races_data = API::V2::RaceSerializer.render(races, view: :with_edition, root: :races)
      render json: races_data
    end
  end

  private

  def render_edition_races
    edition = Edition.available.find_by(id: params[:edition_id])
    return [] unless edition
    raw_races = edition.races.map do |race|
      {
        id:                              race.id,
        name:                            race.name,
        email_sender:                    race.email_sender,
        email_name:                      race.email_name,
        date:                            race.date,
        hashtag:                         race.hashtag,
        results_url:                     race.results_url,
        sms_message:                     race.sms_message,
        created_at:                      race.created_at,
        updated_at:                      race.updated_at,
        raw_results_file_name:           race.raw_results_file_name,
        raw_results_content_type:        race.raw_results_content_type,
        raw_results_file_size:           race.raw_results_file_size,
        raw_results_updated_at:          race.raw_results_updated_at,
        external_link:                   race.external_link,
        edition_id:                      race.edition_id,
        coef:                            race.coef,
        category:                        race.category,
        department:                      race.department,
        race_type:                       race.race_type
      }
    end

    render json: raw_races
  end
end
