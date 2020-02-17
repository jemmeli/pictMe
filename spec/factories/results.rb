FactoryGirl.define do
  factory :result do
    sequence(:name) {|n| "Result_#{n}"}
    sequence(:phone) {|n| "+33#{n}#{n}#{n}#{n}#{n}#{n}#{n}#{n}"}
    sequence(:mail) {|n| "contact@#{n}.com"}
    sequence(:rank) {|n| "#{n}"}
    country {"FR"}
    sequence(:bib) {|n| "Bib_#{n}"}
    sequence(:categ_rank) {|n| "#{n}"}
    sequence(:categ) {|n| "Categ_#{n}"}
    sequence(:sex_rank) {|n| "#{n}"}
    sex {"M"}
    sequence(:time) {|n| "#{n}'#{n}''#{n}'"}
    sequence(:speed) {|n| "#{n}km/h"}
    sequence(:message) {|n| "Congrats ! #{n}"}
    sequence(:race_detail) {|n| "Race #{n}"}
    sequence(:diploma_url) {|n| "www.result_#{n}.com"}
    sequence(:points) { |n| "#{n}" }
    sequence(:first_name) { |n| "First_#{n}" }
    sequence(:last_name) { |n| "Last_#{n}" }
    dob { DateTime.now.to_s }
  end
end