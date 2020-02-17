class GenerateDiplomaJob < ActiveJob::Base
  queue_as :normal

  def perform(result_id)
    result = Result.find(result_id)
    diploma = GenerateDiploma.new(result).image_kit(IMAGE_HEIGHT[result.edition.template],IMAGE_WIDTH[result.edition.template])
    diploma_file = Tempfile.open(['diploma', 'jpg']) do |f|
      f << diploma.to_img(:jpg).force_encoding('UTF-8')
    end
    result.diploma = open diploma_file
    result.diploma_generated_at = Time.now
    result.save
  end
end
