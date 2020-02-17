class AddDistanceToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :distance, :float
  end
end
