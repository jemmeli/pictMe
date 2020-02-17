class AddWidgetGenerationInfoToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :widget_generated_at, :datetime
  end
end
