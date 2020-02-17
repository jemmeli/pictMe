class AddEditionIdToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :edition_id, :integer
    add_column :photos, :edition_id, :integer
  end
end
