class AddDirectImageUrlToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :direct_image_url, :string
  end
end
