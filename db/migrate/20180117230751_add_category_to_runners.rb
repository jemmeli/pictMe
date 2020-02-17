class AddCategoryToRunners < ActiveRecord::Migration[5.0]
  def change
    add_column :runners, :category, :string
  end
end
