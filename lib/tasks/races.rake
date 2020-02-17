namespace :races do
  desc "Set races start_at"
  task set_races_start_at: :environment do
    puts "### Beginning of races start_at ###"

    Race.all.each do |race|
      if race.date
        date = race.date
      elsif race.edition && race.edition.date
        date = race.edition.date
      end
      
      if race.date || (race.edition && race.edition.date)
        new_datetime = Time.new(date.year, date.month, date.day, 9)
        race.update(start_at: new_datetime)
        puts "Set #{race.start_at} for #{race.name}"
      end
    end

    puts "### End of races start_at ###"
  end

  desc "Set races distance"
  task set_races_distance: :environment do
    puts "### Beginning of races distance ###"

    find_km_regex            = /(\d+((\.|,)\d*)?)\s*km/i
    find_m_regex             = /(\d+((\.|,)\d*)?)\s*m(\s+|\z)/i
    find_miles_regex         = /(\d+((\.|,)\d*)?)\s*miles(\s+|\z)/i
    find_marathon_regex      = /(\A|\s+)(marathon)(\s+|\z)/i
    find_semi_marathon_regex = /(semi-marathon)(\s+|\z)/i
    one_mile_in_kms          = 1.609344
    marathon_in_kms          = 42.195
    semi_marathon_in_kms     = 21.097

    Race.all.each do |race|
      km_match = find_km_regex.match(race.name)
      if km_match
        race_km = km_match[1].gsub(',','.').to_f
        race.update(distance: race_km)
      end

      m_match = find_m_regex.match(race.name)
      if m_match
        race_m = m_match[1].gsub(',','.').to_f
        race.update(distance: race_m / 1000)
      end

      miles_match = find_miles_regex.match(race.name)
      if miles_match
        race_mile = miles_match[1].gsub(',','.').to_f
        race.update(distance: race_mile * one_mile_in_kms)
      end

      marathon_match = find_marathon_regex.match(race.name)
      if marathon_match
        race.update(distance: marathon_in_kms)
      end

      semi_marathon_match = find_semi_marathon_regex.match(race.name)
      if semi_marathon_match
        race.update(distance: semi_marathon_in_kms)
      end

      if km_match || m_match || miles_match || marathon_match || semi_marathon_match
        puts "Set #{race.name} at #{race.distance} km"
      end
    end

    puts "### End of races distance ###"
  end
end