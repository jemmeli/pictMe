class AddTypeToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :race_type, :string
  end
end
