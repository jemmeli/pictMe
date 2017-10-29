# == Schema Information
#
# Table name: editions
#
#  id          :integer          not null, primary key
#  date        :date
#  description :string
#  event_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Edition < ApplicationRecord
  # Relations
  belongs_to :event
  has_many :races
  has_many :results, dependent: :destroy
  has_many :photos

  has_attached_file :raw_results
  has_attached_file :background_image, styles: { medium: "300x300", standard: "1024x1024" }

  # Validations
  validates :event_id, presence: true
  validates_attachment_content_type :raw_results, :content_type => ["text/plain", "text/csv", "application/vnd.ms-excel", "text/comma-separated-values",  Paperclip::ContentTypeDetector::SENSIBLE_DEFAULT]
  validates_attachment_content_type :background_image, content_type: /\Aimage\/.*\z/
  validates_presence_of :date, :template, :description


  TEMPLATES = Dir.glob("#{Rails.root}/app/views/diploma/*.html.erb").map{|template| template.split('/').last}.map{|template| template.gsub('.html.erb','')}
  # ['template1', 'texte-ombre']

  before_save do |race|
    self.sms_message = I18n.t('sms_message_template') if self.sms_message.blank?
  end

  def runners_count
    @runners_count ||= results.count
  end

  def races_count
    @races_count ||= results.select(:race_detail).uniq.count
  end

  def race_detail
    @races ||= results.select(:race_detail).uniq.pluck(:race_detail)
  end

  def emails_count
    @emails_count ||= results.pluck(:mail).select{|mail| mail =~ MAIL_REGEX}.length
  end

  def phones_count
    @phones_count ||= results.pluck(:phone).select{|phone| phone =~ PHONE_REGEX}.length
  end

  def widget_storage_name
    "#{self.date.year}/#{self.date.month}/#{self.id}"
  end

  def photos_widget_storage_name
    "#{self.date.year}/#{self.date.month}/photos_#{self.id}"
  end

  def widget_url
    "https://s3-eu-west-1.amazonaws.com/results-widget.kapp10.com/#{widget_storage_name}"
  end

  def photos_widget_url
    "https://s3-eu-west-1.amazonaws.com/results-widget.kapp10.com/#{photos_widget_storage_name}"
  end

  def widget_gist
    %(
	<iframe class='kapp10-embed' src="//s3-eu-west-1.amazonaws.com/results-widget.kapp10.com/#{widget_storage_name}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1100px;" scrolling="no"></iframe>)
  end

  def photos_widget_gist
    %(
			<iframe class='kapp10-embed' src="//s3-eu-west-1.amazonaws.com/results-widget.kapp10.com/#{photos_widget_storage_name}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1000px;" scrolling="no"></iframe>)
  end

  def generate_diplomas
    results.where("diploma_generated_at < uploaded_at or diploma_generated_at is null").pluck(:id).each do |id|
      GenerateDiplomaJob.perform_later(id)
    end
  end

  def delete_diplomas
    results.each do |result|
      result.update_attributes({diploma_generated_at: nil, diploma_url: nil})
    end
  end
end
