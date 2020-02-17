class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.references :runner, index: true
      t.references :race, type: :uuid, null: false, index: true
      t.integer :points
      t.string :race_type
      t.datetime :date

      t.timestamps
    end
  end
end
