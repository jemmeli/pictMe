class AddResultFileAndBackgroungImageToEdition < ActiveRecord::Migration[5.0]
  def change
    add_attachment :editions, :raw_results
    add_attachment :editions, :background_image
  end
end
