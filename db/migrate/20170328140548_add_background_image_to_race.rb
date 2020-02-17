class AddBackgroundImageToRace < ActiveRecord::Migration
  def up
    add_attachment :races, :background_image
  end

  def down
    remove_attachment :races, :background_image
  end

end
