FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Event_#{n}" }
    sequence(:place) { |n| "Place_#{n}" }
    sequence(:website) { |n| "www.event_#{n}.com" }
    sequence(:facebook) { |n| "Event_#{n}" }
    sequence(:twitter) { |n| "@Event_#{n}" }
    sequence(:instagram) { |n| "@Event_#{n}" }
    sequence(:contact) { |n| "contact@event_#{n}.com" }
    sequence(:email) { |n| "contact@event_#{n}.com" }
    sequence(:phone) { |n| "+33#{n}#{n}#{n}#{n}#{n}#{n}#{n}#{n}" }
  end
end