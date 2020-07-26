class PhotoTransferAndCleanupJob < ActiveJob::Base
  queue_as :normal

  def perform(photo_id)
    photo = Picture.find(photo_id)
    direct_image_url_data = Photo::DIRECT_IMAGE_URL_FORMAT.match(photo.direct_image_url)

    if photo.post_process_required?
      photo.image = URI.parse(URI.escape(photo.direct_image_url))
    end

    photo.save
  end
end
