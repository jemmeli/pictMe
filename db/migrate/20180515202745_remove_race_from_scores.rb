class RemoveRaceFromScores < ActiveRecord::Migration[5.0]
  def change
    remove_column :scores, :race_id
  end
end
