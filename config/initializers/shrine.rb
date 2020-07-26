require "shrine/storage/s3"
 
s3_options = { 
  access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
  secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
  region:            ENV["AWS_REGION"],
  bucket:            ENV["AWS_BUKET"], # required 
}
 
Shrine.storages = { 
  cache: Shrine::Storage::S3.new(prefix: "cache", upload_options: { acl: "public-read" }, **s3_options),
  store: Shrine::Storage::S3.new(prefix: "store", upload_options: { acl: "public-read" }, **s3_options),
}


Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :direct_upload
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files