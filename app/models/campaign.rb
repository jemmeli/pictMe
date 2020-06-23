class Campaign < ApplicationRecord
    belongs_to :edition
    has_many :contacts
  
end