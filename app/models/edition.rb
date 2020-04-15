class Edition < ApplicationRecord
  # Relations
  belongs_to :event
  has_many :races
  has_many :results, dependent: :destroy
  has_many :photos
  has_many :diplomas
  has_many :runners, through: :results
  has_many :contacts

  has_attached_file :raw_results
  has_attached_file :background_image, styles: { medium: "300x300", standard: "1024x1024" }

  monetize :sendable_at_home_price_cents, allow_nil: true
  monetize :download_chargeable_price_cents, allow_nil: true

  # Validations
  validates :event_id, presence: true
  validates_attachment_content_type :raw_results, :content_type => ["text/plain", "text/csv", "application/vnd.ms-excel", "text/comma-separated-values",  Paperclip::ContentTypeDetector::SENSIBLE_DEFAULT]
  validates_attachment_content_type :background_image, content_type: /\Aimage\/.*\z/
  validates_presence_of :date, :template, :description
  validates :sendable_at_home_price, numericality: { greater_than: 0, if: :sendable_at_home? }
  validates :download_chargeable_price, numericality: { greater_than: 0, if: :download_chargeable? }
  validates :sendable_at_home_price, numericality: { equal_to: 0, unless: :sendable_at_home? }
  validates :download_chargeable_price, numericality: { equal_to: 0, unless: :download_chargeable? }

  def self.with_lastest_results(limit = 3)
    return [] unless limit > 0

    last_result = Result.order(created_at: :desc).first

    return [] if last_result.nil?

    results  = [last_result]
    editions = [Edition.find(last_result.edition_id)]


    (limit-1).times do
      matching_results = Result.where.not(edition_id: editions.map { |edition| edition.id }).order(created_at: :desc)
      if matching_results.any?
        results << matching_results.first
        editions << Edition.find(matching_results.first.edition_id)
      end
    end

    { editions: editions, results: results }
  end

  def self.next(limit = 3)
    return [] unless limit > 0

    where("date >= ?", Date.today).limit(limit)
  end

  def self.available
    Edition.where(
      id: [
        Edition.joins(races: :results).
          group("editions.id").
          where("editions.date < ? AND editions.event_id IS NOT NULL", Date.today).
          having("COUNT(*) > 1").
          pluck("editions.id"),
        Edition.where("editions.date >= ?", Date.today).
          pluck(:id)
      ].flatten
    )
  end

  TEMPLATES = Dir.glob("#{Rails.root}/app/views/diploma/*.html.erb").map{|template| template.split('/').last}.map{|template| template.gsub('.html.erb','')}
  # ['template1', 'texte-ombre']

  S3_BASE_URL = "https://#{ENV['AWS_S3_HOST_NAME_REGION']}.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}"

  before_save do |race|
    self.sms_message = I18n.t('sms_message_template') if self.sms_message.blank?
  end

  def runners_count
    @runners_count ||= results.count
  end

  def races_count
    @races_count ||= results.select(:race_detail).distinct.count
  end

  def race_detail
    @races ||= results.select(:race_detail).distinct.pluck(:race_detail)
  end

  def emails_count
    @emails_count ||= results.pluck(:mail).select{|mail| mail =~ MAIL_REGEX}.length
  end

  def phones_count
    @phones_count ||= results.pluck(:phone).select{|phone| phone =~ PHONE_REGEX}.length
  end

  def get_widget_diplomas_json(edition_id)
    results     = self.results
    diplomas = []
    results.each do |r|
      if r.diploma.url
        diplomas << {
          edition_id: edition_id,
          bib: (r.bib) ? r.bib : "",
          result_id: r.id,
          url: r.diploma.url,
          rank:  (r.rank) ? r.rank : r.size + 1,
          race:  r.race_detail.parameterize,
          sex:   r.sex.parameterize,
          categ: r.categ.parameterize,
          firstname: (r.first_name)? r.first_name.gsub(/'/, " ") : "",
          lastname: (r.last_name) ? r.last_name.gsub(/'/, " ") : "",
          name:  (r.name) ? r.name.gsub(/'/, " "): "" # fix problem with `'` in names 
          }
      end
    end
    diplomas.to_json
  end

  def get_widget_photos_json
    results     = self.results
    photos      = self.photos.map do |photo|
      result = results.select{ |r| r.bib === photo.bib }.first

      if result
        if result.name
          name = result.name
        else
          name = "#{result.first_name} #{result.last_name}"
        end
      else
        name = ''
      end

      {
        url:   ENV['RAILS_ENV'] == 'development' ? photo.direct_image_url : photo.image.url,
        bib:   photo.bib || "",
        rank:  (result && result.rank) ? result.rank : results.size + 1,
        race:  result ? result.race_detail.parameterize : '',
        sex:   result ? result.sex.parameterize : '',
        categ: result ? result.categ.parameterize : '',
        name:  name.gsub(/'/, " "), # fix problem with `'` in names 🤷
      }
    end

    photos = photos.sort_by{|photo| photo[:rank]}

    photos.to_json
  end

  def widget_storage_name
    "results/#{self.date.year}/#{self.date.month}/#{self.id}"
  end

  def photos_widget_storage_name
    "photos/#{self.date.year}/#{self.date.month}/photos_#{self.id}"
  end

  def diplomas_widget_storage_name
    "diplomas/#{self.date.year}/#{self.date.month}/diplomas_#{self.id}"
  end

  def widget_url
    "#{S3_BASE_URL}/#{widget_storage_name}"
  end

  def photos_widget_url
    "#{S3_BASE_URL}/#{photos_widget_storage_name}"
  end

  def diplomas_widget_url
    p diplomas_widget_storage_name
    "#{S3_BASE_URL}/#{diplomas_widget_storage_name}"
  end

  def widget_gist
    %(
	<iframe class='kapp10-embed' src="#{widget_url}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1100px;" scrolling="no"></iframe>)
  end

  def photos_widget_gist
    %(
			<iframe class='kapp10-embed' src="#{photos_widget_url}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1400px;" scrolling="no"></iframe>)
  end

  def diplomas_widget_gist
    %(
			<iframe class='kapp10-embed' src="#{diplomas_widget_url}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1400px;" scrolling="no"></iframe>)
  end

  def generate_diplomas
    results.where("diploma_generated_at < uploaded_at or diploma_generated_at is null").pluck(:id).each do |id|
      GenerateDiplomaJob.perform_later(id)
    end
  end

  def delete_diplomas
    results.each do |result|
      result.diploma = nil
      result.diploma_generated_at = nil
      result.save
    end
  end
end
