class PhotoSerializer < ActiveModel::Serializer

  attributes :id, :points, :date, :created_at, :updated_at
  has_one :runner
end
