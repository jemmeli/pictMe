class PhotoSerializer < ActiveModel::Serializer

  attributes :id, :suggested_bibs, :bib, :created_at, :updated_at, :image_file_name, :image_content_type, :image_file_size, :image_updated_at
  has_one :edition
  has_one :race
end
