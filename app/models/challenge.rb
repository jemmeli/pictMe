class Challenge < ApplicationRecord
  # Relations
  has_many :events
  has_many :races, through: :events
  has_many :scores, through: :races, source: :scores

  # Validation
  validates :name, presence: true

  def widget_storage_name
    "challenges/#{self.name}/#{self.id}"
  end

  def widget_url
    "https://s3-eu-west-1.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}/#{widget_storage_name}"
  end

  def widget_gist
    %(
	<iframe class='kapp10-embed' src="//s3-eu-west-1.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}/#{widget_storage_name}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1100px;" scrolling="no"></iframe>)
  end

  def self.global_widget_url
    "https://s3-eu-west-1.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}/challenges/global"
  end

  def self.global_widget_gist
    %(
	<iframe class='kapp10-embed' src="//s3-eu-west-1.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}/challenges/global" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1100px;" scrolling="no"></iframe>)
  end
end