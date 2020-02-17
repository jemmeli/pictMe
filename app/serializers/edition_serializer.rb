class EditionSerializer < ActiveModel::Serializer

  attributes :id, :date, :description, :email_sender, :hashtag, :results_url, :sms_message, :template, :widget_generated_at, :photos_widget_generated_at, :external_link, :external_link_button, :created_at, :updated_at, :raw_results_file_name, :raw_results_content_type, :raw_results_file_size, :raw_results_updated_at, :background_image_file_name, :background_image_content_type, :background_image_file_size, :background_image_updated_at
  has_one :event

end
