# == Schema Information
#
# Table name: clients
#
#  id             :integer          not null, primary key
#  name           :string
#  results_widget :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Client < ApplicationRecord
  # Validation
  validates :name, presence: true

  def widget_storage_name
    "clients/#{self.name}/#{self.id}"
  end

  def widget_url
    "https://#{ENV['AWS_S3_HOST_NAME_REGION']}.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}/#{widget_storage_name}"
  end

  def widget_gist
    %(
	<iframe class='kapp10-embed' src="//#{ENV['AWS_S3_HOST_NAME_REGION']}.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}/#{widget_storage_name}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1100px;" scrolling="no"></iframe>)
  end
end
