task migrate_diplomas_to_paperclip: :environment do
  results = Result.where.not(diploma_url: nil)
  puts "*** START MIGRATING #{results.count} DIPLOMAS ***"
  results.find_each do |result|
    begin
      puts "Migrating result #{result.id}..."
      puts "Retrieving original S3 url..."
      response = HTTParty.get(result.diploma_url)
      original_s3_url = response.request.last_uri.to_s

      puts "Uploading remote S3 file as a paperclip attachment..."
      result.diploma = URI.parse original_s3_url

      puts "Deleting the old S3 file..."
      base_s3_url, complete_image_name = original_s3_url.split "/#{KAPP10_FINISHLINE_BUCKET.name}/"
      s3_object = KAPP10_FINISHLINE_BUCKET.object(complete_image_name)
      s3_object.delete
      result.diploma_url = nil
      result.save!
      
      puts "Result #{result.id} migrated."
    rescue => e
      p "## ERROR ## : #{result.id}"
      p result.errors
      p e
      next
    end
  end
end
