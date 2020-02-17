class AddIndexesToRunners < ActiveRecord::Migration[5.0]
  def change
    add_index :runners, [:last_name, :first_name]
  end
end
