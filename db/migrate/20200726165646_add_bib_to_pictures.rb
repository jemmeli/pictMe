class AddBibToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :bib, :string
    add_column :pictures, :image_content_type, :string
  end
end
