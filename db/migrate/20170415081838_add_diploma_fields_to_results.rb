class AddDiplomaFieldsToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :diploma_url, :string
  end
end
