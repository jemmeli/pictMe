class Contact < ApplicationRecord
  belongs_to :edition
  has_many :pictures

end