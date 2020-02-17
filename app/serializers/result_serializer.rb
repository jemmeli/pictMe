class ResultSerializer < ActiveModel::Serializer

  attributes :id, :phone, :mail, :rank, :name, :country, :bib, :categ_rank, :categ, :sex_rank, :time, :speed, :message, :race_detail, :created_at, :updated_at, :uploaded_at, :diploma_generated_at, :email_sent_at, :sms_sent_at, :diploma_url, :points, :first_name, :last_name, :dob
  has_one :race
  has_one :edition
  has_one :runner
end
