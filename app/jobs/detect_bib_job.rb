class DetectBibJob < ActiveJob::Base
  queue_as :normal

  def perform(photo_id)
    photo = Photo.find(photo_id)

    vision = ::Google::Cloud::Vision.new project: "kapp10-freshstart-ocr", keyfile: JSON.parse(ENV["GOOGLE_CLOUD_KEYFILE_JSON"])
    image = vision.image photo.image.url
    annotation = vision.annotate image, text: true

    return unless annotation.text.present?
    bib = annotation.text.to_s.match(/\d+/)[0]
    photo.bib = bib
    
    result = photo.edition.results.find_by(bib: bib)
    
    if result
      photo.race = result.race 
      photo.runner = result.runner
    end

    photo.save!
  end
end
