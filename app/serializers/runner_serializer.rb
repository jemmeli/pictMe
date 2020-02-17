class RunnerSerializer < ActiveModel::Serializer

  attributes :id, :id_key, :first_name, :last_name, :dob, :department, :sex, :created_at, :updated_at
end
