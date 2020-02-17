FactoryGirl.define do
  factory :photo do
    sequence(:suggested_bibs) {|n| "Suggested_bib_#{n}"}
    sequence(:bib) {|n| "Bib_#{n}"}
    sequence(:image_file_name) {|n| "test_#{n}.jpg"}
    image_content_type {"image/jpg"}
    image_file_size {19024}
    image_updated_at {DateTime.now.to_s}
  end
end