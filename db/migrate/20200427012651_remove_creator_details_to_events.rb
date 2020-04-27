class RemoveCreatorDetailsToEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :fname, :string
    remove_column :events, :lname, :string
  end
end
