class Picture < ApplicationRecord

    belongs_to :edition
    include ImageUploader[:image]
    
end
