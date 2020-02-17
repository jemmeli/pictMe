class PhotoSearchService
  def initialize(edition, search_params)
    @edition = edition
    @race_ids = search_params[:race_ids]
    @without_bib = search_params[:without_bib]
    @sexes = search_params[:sex]
    @categories = search_params[:categ]
  end

  def fetch_ids
    photos = @race_ids.present? ? @edition.photos.where(race_id: @race_ids) : @edition.photos
    photos = photos.where(bib: nil) if @without_bib
    photos = photos.select { |p| p.runner.is_a?(Result) && p.runner.sex.in?(@sexes) } if @sexes.present?
    photos = photos.select { |p| p.runner.is_a?(Result) && p.runner.categ.in?(@categories) } if @categories.present?
    photos.map(&:id)
  end
end
