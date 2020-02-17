require 'htmlentities'
require 'htmlcompressor'

class GeneratePhotosWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(edition_id)
    @edition      = Edition.find(edition_id)
    @categories   = @edition.results.pluck(:categ).uniq.sort
    @photos_json  = @edition.get_widget_photos_json
    @generated_at = Time.now

    erb_file = "#{Rails.root}/app/views/editions/photos_widget.html.erb"
    erb_str  = File.read(erb_file)
    renderer = ERB.new(erb_str)

    if renderer
      html       = renderer.result(binding)
      compressor = HtmlCompressor::Compressor.new
      KAPP10_WIDGETS_BUCKET.object(@edition.photos_widget_storage_name).put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
      @edition.update_attribute(:photos_widget_generated_at, @generated_at)
    end
  end
end
