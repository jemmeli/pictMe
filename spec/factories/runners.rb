FactoryBot.define do
  factory :runner do
    sequence(:id_key) {|n| "ID_#{n}"}
    sequence(:first_name) {|n| "First_#{n}"}
    sequence(:last_name) {|n| "Last_#{n}"}
    sequence(:dob) {"2017-11-16 11:05:06"}
    sequence(:department) {"40"}
    sequence(:sex) {"M"}
  end
end
