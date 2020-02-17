namespace :events do
  desc "Set events geocoding"
  task geocode: :environment do
    puts "### Beginning of events geocoding ###"

    Event.where.not(place: [nil, ""]).each do |event|
      event.geocode
      event.save
      puts "#{event.name}: lat: #{event.latitude}, lng: #{event.longitude}"
    end

    puts "### End of events geocoding ###"
  end

  # desc "Set events geocoding"
  # task geocode: :environment do
  #   puts "### Beginning of events geocoding ###"

  #   Event.where.not(place: [nil, ""]).each do |event|
  #     event.geocode
  #     event.save
  #     puts "#{event.name}: lat: #{event.latitude}, lng: #{event.longitude}"
  #   end

  #   puts "### End of events geocoding ###"
  # end
end
