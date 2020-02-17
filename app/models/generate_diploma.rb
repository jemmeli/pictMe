# include Rails.application.routes.url_helpers

class GenerateDiploma
  def initialize(result, photo_format=:standard)
    @result = (result.class == String) ? Result.find(result) : result
    @template =  @result.edition.template
    @name = "#{@result.first_name} #{@result.last_name}"
    @rank = @result.rank
    @time = @result.time
    @speed = @result.speed
    @number = @result.bib
    @message = @result.message
    @rank_total = @result.rank_total
    @race_name = "#{@result.edition.event.name}"
    @race_date = I18n.l @result.edition.date
    @race_detail = @result.race_detail
    if @result.photo == :no_photo
      @background_image_url = @result.edition.background_image.url(photo_format)
    else
      @background_image_url = @result.photo.image.url
    end
    Rails.logger.debug "width = #{IMAGE_WIDTH[@template]}"
    Rails.logger.debug "height = #{IMAGE_HEIGHT[@template]}"
  end

  def html
    return @html if @html
    #on génère le HTML contenant ces informationsv
    erb_file = "#{Rails.root}/app/views/diploma/#{@template}.html.erb"
    erb_str = File.read(erb_file)
    renderer = ERB.new(erb_str)
    return nil unless renderer
    renderer.result(binding)
  end

  def image_kit(height, width)
    IMGKit.new html, height: IMAGE_HEIGHT[@template],
                     width: IMAGE_WIDTH[@template]
  end
end
