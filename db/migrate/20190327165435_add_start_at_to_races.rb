class AddStartAtToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :start_at, :datetime
  end
end