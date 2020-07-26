class AddEditionIdToPictures < ActiveRecord::Migration[5.0]
  def change
    add_reference :pictures, :edition, foreign_key: true
  end
end
