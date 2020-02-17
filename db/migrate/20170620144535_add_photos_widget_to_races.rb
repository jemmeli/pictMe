class AddPhotosWidgetToRaces < ActiveRecord::Migration[5.0]
  def change
		add_column :races, :photos_widget_generated_at, :datetime
  end
end
