class RaceQuery < BaseQuery
  def self.relation(base_relation = nil)
    super(base_relation, Race.available)
  end

  def lastest
    select('races.*, editions.date').
      joins(:edition).
      where('editions.date <= ?', Date.today).
      order('editions.date DESC')
  end

  def next_races
    select('races.*, editions.date').
      joins(:edition).
      where('editions.date >= ?', Date.today).
      order('editions.date ASC')
  end

  def lastest_with_results
    lastest.joins(:results).distinct
  end
end
