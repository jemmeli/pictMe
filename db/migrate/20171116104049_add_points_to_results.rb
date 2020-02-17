class AddPointsToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :points, :integer
    add_column :results, :first_name, :string
    add_column :results, :last_name, :string
    add_column :results, :dob, :datetime
  end
end
