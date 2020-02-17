class AddS3InfoToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :direct_image_url, :string
    add_column :photos, :processed, :boolean, default: false, index: true
  end
end
