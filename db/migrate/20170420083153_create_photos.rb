class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos , id: :uuid do |t|
      t.references :race, foreign_key: true, index: true, type: :uuid
      t.string :suggested_bibs
      t.string :bib

      t.timestamps
    end
    add_attachment :photos, :image
  end
end
