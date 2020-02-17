class CreateResults < ActiveRecord::Migration
  def change
    create_table :results , id: :uuid do |t|
      t.references :race, index: true, foreign_key: true, type: :uuid
      t.string :phone
      t.string :mail
      t.integer :rank
      t.string :name
      t.string :country
      t.string :bib
      t.integer :categ_rank
      t.string :categ
      t.integer :sex_rank
      t.string :sex
      t.string :time
      t.string :speed
      t.string :message
      t.string :race_detail

      t.timestamps null: false
    end
  end
end
