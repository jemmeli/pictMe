require 'htmlentities'
require 'htmlcompressor'

class GenerateWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(edition_id)
    @edition = Edition.includes(:results).find(edition_id)
		@categories = @edition.results.pluck(:categ).uniq

		@categories_sorted = Hash.new
		@edition_longest_name = Hash.new
		@edition_lines = Hash.new
		@edition.results.order([:race_detail, :rank]).group_by(&:race_detail).each do |edition, results|
      next if edition.nil?

			@edition_longest_name[edition] = results.pluck(:last_name).compact.group_by(&:size).max.last[0].length
			female_sorted = results.select do |result|
				result['sex'] && result['sex'] == "F"
			end
			male_sorted = results.select do |result|
				result['sex'] && (result['sex'] == "M" || result['sex'] == 'H')
			end
			all_sorted = results.select do |result|
				result['sex'] && (result['sex'] == "M" || result['sex'] == "H" || result['sex'] == "" || result['sex'] == 'F')
			end
			female_categories = female_sorted.map { |f| f['categ'] }.uniq
			male_categories = male_sorted.map { |m| m['categ'] }.uniq
			all_categories = all_sorted.map { |a| a['categ'] }.uniq
			@categories_sorted[edition.parameterize] = { F: female_categories, M: male_categories, ALL: all_categories }
		end
    @generated_at = Time.now
		p 'before erb'
    erb_file = "#{Rails.root}/app/views/editions/widget.html.erb"
		p 'before file read'
    erb_str = File.read(erb_file)
		p 'before render'
    renderer = ERB.new(erb_str)
		p 'after render'
    if renderer
      html = renderer.result(binding)
			p 'after html'
      compressor = HtmlCompressor::Compressor.new
			p 'after compresssor'
      KAPP10_WIDGETS_BUCKET.object(@edition.widget_storage_name).put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
      @edition.update_attribute(:widget_generated_at, @generated_at)
    end
  end
end
