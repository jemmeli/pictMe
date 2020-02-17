class AddEditionToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :edition_id, :integer
    add_index :races, :edition_id
  end
end
