class DecodeResultsFileJob < ActiveJob::Base
  queue_as :normal

  def perform(race_id)
    race = Race.find(race_id)
    DecodeResults.new.call(race, race.raw_results.url)
    # race.generate_diplomas
  end
end