class PhotoTransferAndCleanupJob < ActiveJob::Base
  queue_as :normal

  def perform(photo_id)
    photo = Photo.find(photo_id)
    direct_image_url_data = Photo::DIRECT_IMAGE_URL_FORMAT.match(photo.direct_image_url)

    if photo.post_process_required?
      photo.image = URI.parse(URI.escape(photo.direct_image_url))
    else
      paperclip_file_path = "photos/uploads/#{photo_id}/original/#{direct_image_url_data[:filename]}"
      KAPP10_FINISHLINE_BUCKET.object(paperclip_file_path).copy_from(direct_image_url_data[:path])
    end

    photo.processed = true
    photo.save

    KAPP10_FINISHLINE_BUCKET.object(direct_image_url_data[:path]).delete
  end
end
