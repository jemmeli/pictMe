require 'htmlentities'
require 'htmlcompressor'

class GenerateDiplomasWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(edition_id)
    # p "Edition id: " 
    # p edition_id
    @edition      = Edition.find(edition_id)
    @categories   = @edition.results.pluck(:categ).uniq.sort
    @diplomas  = @edition.get_widget_diplomas_json(@edition.id)
    @generated_at = Time.now

    # p @diplomas

    # p ">>>>>>>>>>>>>> 1"
    erb_file = "#{Rails.root}/app/views/editions/diplomas_widget.html.erb"
    erb_str  = File.read(erb_file)
    # p ">>>>> ERB STR >>>>>>>>>>>>>>>>"
    # p erb_str
    renderer = ERB.new(erb_str)

    if renderer
      # p ">>>>>>>>>>>>    renderer ok"
      html       = renderer.result(binding)
      # p html
      compressor = HtmlCompressor::Compressor.new
      KAPP10_WIDGETS_BUCKET.object(@edition.diplomas_widget_storage_name).put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
      p @generated_at
      @edition.update_attribute(:diplomas_widget_generated_at, @generated_at)
    else
      # p ">>>>>>>>>>>>>   renderer failed!"
    end
  end
end
