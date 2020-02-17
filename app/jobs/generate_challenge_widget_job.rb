require 'htmlentities'
require 'htmlcompressor'

class GenerateChallengeWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(challenge_id)
    @challenge = Challenge.find(challenge_id)
    scores = []

    # get races
    race_ids = @challenge.race_ids.compact
    # get runners
    runner_ids = Result.where(race_id: race_ids).pluck(:runner_id).compact

    # get scores
    # [0 first_name, 1 last_name, 2 points, 3 nb_courses, 4 sex, 5 category, 6 race_type]
    Score.includes(:runner).where(runner_id: runner_ids).find_each do |s|
      scores << [s.runner.first_name, s.runner.last_name, s.points, runner_ids.count(s.runner_id), s.runner.sex, s.runner.category, s.race_type]
    end
    @scores = scores

    @categories = @scores.map { |s| s[5] }.compact.uniq
    @types = @scores.map { |s| s[6] }.compact.uniq
    @categories_sorted = Hash.new
    @edition_longest_name = Hash.new
    @edition_lines = Hash.new

    @scores.sort_by { |s| s[2] }.group_by { |s| s[6] }.each  do |race_type, scores|
      @edition_longest_name[@challenge.name] = scores.sort_by { |s| s[1].size }.last.size

      female_sorted = scores.select { |score| score[4] && score[4] == 'F' }
      male_sorted = scores.select { |score|  score[4] && (score[4] == 'M' || score[4] == 'H') }
      all_sorted = scores.select { |score| score[4] && (score[4] == 'M' || score[4] == 'F' || score[4] == '' || score[4] == 'H') }

      female_categories = female_sorted.map { |f| f[5] }.compact.uniq
      male_categories = male_sorted.map { |m| m[5] }.compact.uniq
      all_categories = all_sorted.map { |a| a[5] }.compact.uniq

      @categories_sorted[race_type] = { F: female_categories, M: male_categories, ALL: all_categories }
    end
    erb_file = "#{Rails.root}/app/views/challenges/widget.html.erb"
    erb_str = File.read(erb_file)
    renderer = ERB.new(erb_str)
    if renderer
      html = renderer.result(binding)
      compressor = HtmlCompressor::Compressor.new
      KAPP10_WIDGETS_BUCKET.object(@challenge.widget_storage_name).put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
      @challenge.update_attribute(:widget, @challenge.widget_gist)
    end
  end
end
