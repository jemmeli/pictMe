require 'htmlentities'
require 'htmlcompressor'

class GenerateGlobalChallengeWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform
    runners = []
    scores = []
    Event.where(global_challenge: true).each { |e| runners << e.runners }

    runners.flatten.uniq.each { |runner| scores << runner.scores }
    @scores = scores.flatten

    @categories = @scores.map { |s| s.runner.category }.compact.uniq
    @types = @scores.pluck(:race_type).uniq
    @categories_sorted = Hash.new
    @edition_longest_name = Hash.new
    @edition_lines = Hash.new
    # @challenge.races.scores.order([:race_type,:points]).group_by(&:race_type).each  do |challenge, scores|
    @scores.sort_by(&:points).group_by(&:race_type).each  do |race_type, scores|
      @edition_longest_name['global'] = scores.map(&:last_name).group_by(&:size).max.last[0].length

      female_sorted = scores.select do |score|
        score.runner.sex && score.runner.sex == 'F'
      end
      male_sorted = scores.select do |score|
        score.runner.sex && (score.runner.sex == 'M' || score.runner.sex == 'H')
      end
      all_sorted = scores.select do |score|
        score.runner.sex && (score.runner.sex == 'M' || score.runner.sex == 'F' || score.runner.sex == '' || score.runner.sex == 'H')
      end
      female_categories = female_sorted.map { |f| f.runner.category }.uniq
      male_categories = male_sorted.map { |m| m.runner.category }.uniq
      all_categories = all_sorted.map { |a| a.runner.category }.uniq

      @categories_sorted[race_type] = { F: female_categories, M: male_categories, ALL: all_categories }
    end
    @generated_at = Time.now
    erb_file = "#{Rails.root}/app/views/challenges/global_widget.html.erb"
    erb_str = File.read(erb_file)
    renderer = ERB.new(erb_str)
    if renderer
      html = renderer.result(binding)
      compressor = HtmlCompressor::Compressor.new
      KAPP10_WIDGETS_BUCKET.object('challenges/global').put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
    end
  end

end
