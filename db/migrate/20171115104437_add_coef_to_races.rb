class AddCoefToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :coef, :integer
    add_column :races, :category, :string
    add_column :races, :department, :string
  end
end
