json.extract! picture, :id, :created_at, :updated_at
json.image_url picture.image.url
json.url api_v1_event_picture_url(@edition, picture, format: :json)
