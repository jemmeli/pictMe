require 'rails_helper'

RSpec.describe RaceQuery, type: 'query' do
  subject(:query) do
    RaceQuery.relation(Race.all)
  end

  let!(:event_paris) do
    Event.create!(
      name:      '10 km de Paris',
      place:     'Paris',
      phone:     '0123456789',
      website:   'www.example.com/10km_paris',
      latitude:  48.8567,
      longitude: 2.3508
    )
  end

  let!(:event_nantes) do
    Event.create!(
      name:      '10 km de Nantes',
      place:     'Nantes',
      phone:     '0123456789',
      website:   'www.example.com/10km_nantes',
      latitude:  47.2181,
      longitude: -1.5528
    )
  end

  let!(:edition_paris_2018) do
    Edition.create!(
      event:         event_paris,
      date:          Date.today - 1.year - 1.day,
      description:   "Édition 2018 paris",
      email_sender:  'orga_10km_paris@example.com',
      email_name:    'Orga 10 km Paris',
      hashtag:       '10km',
      external_link: 'www.example.com/10km_paris/2018',
      template:      'nc',
      sendable_at_home_price_cents:    0,
      download_chargeable_price_cents: 0
    )
  end

  let!(:edition_paris_2019) do
    Edition.create!(
      event:         event_paris,
      date:          Date.today,
      description:   "Édition 2019 paris",
      email_sender:  'orga_10km_paris@example.com',
      email_name:    'Orga 10 km Paris',
      hashtag:       '10km',
      external_link: 'www.example.com/10km_paris/2019',
      template:      'nc',
      sendable_at_home_price_cents:    0,
      download_chargeable_price_cents: 0
    )
  end

  let!(:edition_nantes_2018) do
    Edition.create!(
      event:         event_nantes,
      date:          Date.today - 1.year,
      description:   "Édition 2018",
      email_sender:  'orga_10km_nantes@example.com',
      email_name:    'Orga 10 km Nantes',
      hashtag:       '10km',
      external_link: 'www.example.com/10km_nantes/2018',
      template:      'nc',
      sendable_at_home_price_cents:    0,
      download_chargeable_price_cents: 0
    )
  end

  let!(:edition_nantes_2019) do
    Edition.create!(
      event:         event_nantes,
      date:          Date.today + 1.day,
      description:   "Édition 2019",
      email_sender:  'orga_10km_nantes@example.com',
      email_name:    'Orga 10 km Nantes',
      hashtag:       '10km',
      external_link: 'www.example.com/10km_nantes/2019',
      template:      'nc',
      sendable_at_home_price_cents:    0,
      download_chargeable_price_cents: 0
    )
  end

  let!(:race_paris_2018_pro) do
    Race.create!(
      edition:   edition_paris_2018,
      name:      "Course pro paris 2018",
      race_type: 'route'
    )
  end

  let!(:race_paris_2019_pro) do
    Race.create!(
      edition:   edition_paris_2019,
      name:      "Course pro",
      race_type: 'route'
    )
  end

  let!(:race_nantes_2018_pro) do
    Race.create!(
      edition:   edition_nantes_2018,
      name:      "Course pro Nantes 2018",
      race_type: 'route'
    )
  end

  let!(:race_nantes_2018_trail) do
    Race.create!(
      edition:   edition_nantes_2018,
      name:      "Course trail",
      race_type: 'trail'
    )
  end
    
  let!(:race_nantes_2019_pro) do
    Race.create!(
      edition:   edition_nantes_2019,
      name:      "Course pro Nantes 2019",
      race_type: 'trail'
    )
  end

  let!(:alice) do
    Runner.create!(
      first_name: 'Alice',
      last_name:  'Dupuis',
      dob:        Date.new(2000,2,3),
      sex:        'F',
      category:   'Pro',
      id_key:     1
    )
  end

  let!(:bob) do
    Runner.create!(
      first_name: 'Bob',
      last_name:  'Dupuis',
      dob:        Date.new(1989,2,5),
      sex:        'M',
      category:   'Pro',
      id_key:     2
    )
  end

  let!(:alice_result_paris_2018) do
    Result.create!(
      race:    race_paris_2018_pro,
      edition: race_paris_2018_pro.edition,
      runner:  alice,
      rank:    1,
      speed:   12,
      time:    "50:54:53"
    )
  end

  let!(:alice_result_nantes_2018) do
    Result.create!(
      race:    race_nantes_2018_pro,
      edition: race_nantes_2018_pro.edition,
      runner:  alice,
      rank:    1,
      speed:   12,
      time:    "50:54:53"
    )
  end

  let!(:bob_result_paris_2018) do
    Result.create!(
      race:    race_paris_2018_pro,
      edition: race_paris_2018_pro.edition,
      runner:  bob,
      rank:    2,
      speed:   13,
      time:    "54:54:53"
    )
  end

  describe '#lastest' do
    it 'returns passed races from most recent to least recent' do
      expect(query.lastest.size).to eq(4)
      race = query.lastest.first
      expect(race.edition.description).to eq('Édition 2019 paris')
      race = query.lastest.last
      expect(race.edition.description).to eq('Édition 2018 paris')
    end
  end

  describe '#lastest_with_results' do
    it 'returns races with results' do
      expect(query.lastest_with_results.size).to eq(2)
    end
  end
end
