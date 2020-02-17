FactoryGirl.define do
  factory :race do
    association :edition, factory: :edition
    sequence(:name) {|n| "Race_#{n}"}
    sequence(:email_sender) {|n| "contact@race_#{n}.com"}
    sequence(:email_name) {|n| "Race_#{n}"}
    date {DateTime.now.to_s}
    sequence(:hashtag) {|n| "#HASH#{n}"}
    sequence(:results_url) {|n| "results_#{n}.com"}
    sequence(:sms_message) {|n| "Congratulation for Race#{n}"}
    sequence(:raw_results_file_name) {|n| "raw_Race#{n}"}
    raw_results_content_type {"text/csv"}
    raw_results_file_size {19024}
    sequence(:background_image_file_name) {|n| "raw_Race#{n}"}
    background_image_content_type {"image/jpg"}
    background_image_file_size {19024}
    sequence(:template) {|n| "Template_#{n}"}
    sequence(:external_link) {|n| "Race#{n}.com"}
    sequence(:external_link_button) {|n| "Button_race#{n}.com"}
    sequence(:coef) {|n| "#{n}"}
    sequence(:category) {|n| "Category_#{n}"}
    sequence(:department) {|n| "Department_#{n}"}
    race_type ['trail', 'route', 'funrace'].sample
  end
end
