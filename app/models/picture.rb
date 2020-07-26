class Picture < ApplicationRecord

    belongs_to :edition
	include ImageUploader[:image]

	after_create :queue_processing
	

    #DIRECT_IMAGE_URL_FORMAT = %r{\Ahttps:\/\/#{ENV['AWS_REGION']}\.amazonaws\.com\/#{ENV['AWS_BUKET']}\/(?<path>store\/.+\/(?<filename>.+))\z}.freeze

    # Determines if file requires post-processing (image resizing, etc)
  	#def post_process_required?
    	#%r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}.match(image_content_type).present?
  	#end


	protected
	
    # Queue file processing
  	def queue_processing
    	#return unless self.direct_image_url.present?
    
    	#PhotoTransferAndCleanupJob.perform_later id
		DetectBibJob.perform_later id
		
  	end
    
end
