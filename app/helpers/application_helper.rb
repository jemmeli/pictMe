module ApplicationHelper
  def image_tag_with_at2x(name_at_1x, options={})
    name_at_2x = name_at_1x.gsub(%r{\.\w+$}, '@2x\0')
    image_tag(name_at_1x, options.merge("data-at2x" => asset_path(name_at_2x)))
  end

	def sortable(column, title = nil, edition)
    title ||= column.titleize
		css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
		link_to title, results_event_edition_path(edition.event, edition,
  		params.merge(
    	:sort => column,
    	:direction => direction,
    	:page => nil).permit(:sort, :direction, :page, :search)),
  		{:class => css_class}
	end

	def meta_tag(tag, text)
		content_for :"meta_#{tag}", text
	end

	def yield_meta_tag(tag, default_text='')
		content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
	end

	def has_filter_pict_home?
		@has_filter_pict_home.nil? ? true : @has_filter_pict_home
	end

	def active_btn_class(link_path)
		current_page?(link_path) ? "activeBtn" : ""
	end


end
