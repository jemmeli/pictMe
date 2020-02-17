class DiplomaTransferAndCleanupJob < ActiveJob::Base
  queue_as :normal

  def perform(id)
    diploma = Diploma.find(id)
    direct_image_url_data = Diploma::DIRECT_IMAGE_URL_FORMAT.match(diploma.direct_image_url)

    if diploma.post_process_required?
      diploma.image = URI.parse(URI.escape(diploma.direct_image_url))
    else
      paperclip_file_path = "diplomas/uploads/#{id}/original/#{direct_image_url_data[:filename]}"
      KAPP10_FINISHLINE_BUCKET.object(paperclip_file_path).copy_from(direct_image_url_data[:path])
    end

    diploma.processed = true
    diploma.save

    KAPP10_FINISHLINE_BUCKET.object(direct_image_url_data[:path]).delete
  end
end
